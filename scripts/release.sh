#!/bin/bash

# Originally from https://gist.github.com/devster/b91b97ebbca4db4d02b84337b2a3d933

# Script to simplify the release flow.
# 1) Fetch the current release version
# 2) Increase the version (major, minor, patch)
# 3) Add a new git tag
# 4) Push the tag

function stripPrefix {
  local version=$1
  # this strips off a prefix
  #echo "${version/release-/}"
  echo "${version}"
}

function addPrefix {
  local version=$1
  # this adds a prefix
  #echo "release-${version}"
  echo "${version}"
}

msg="Tagging release"
branch=main

function usage {
  echo "usage: $(basename "$0") -[Mmpnh] [-b <branch>] [-c \"message\"]"
  echo ""
  echo "  -n Dry run"
  echo "  -M for a major release"
  echo "  -m for a minor release"
  echo "  -p for a patch release"
  echo "  -b to specify the branch to be tagged (${branch})"
  echo "  -c to specify the commit message (${msg})"
  echo ""
  echo " Example: release -p -c \"Some fix\""
  echo " means create a patch release with the message \"Some fix\""
  exit 1
}

# Parse command line options.
while getopts ":Mmpnhc:b:" Option
do
  case ${Option} in
    M ) major=true;;
    m ) minor=true;;
    p ) patch=true;;
    n ) noexec=true;;
    b ) branch=$OPTARG;;
    c ) commitMsg=$OPTARG;;
    h ) usage 1>&2;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      usage 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      usage 1>&2
      ;;
  esac
done

shift $((OPTIND - 1))

# Display usage
# need at least one component bumped
if [ -z $major ] && [ -z $minor ] && [ -z $patch ];
then
  usage 1>&2
fi

# Force to the root of the project
pushd "$(dirname "$0")/../"

# 1) Fetch the current release version

echo "Fetch tags"
git fetch --prune --tags

version=$(git describe --abbrev=0 --tags)
version=$(stripPrefix "${version}") # Remove the prefix in the tag release-0.37.10 for example

echo "Current version: ${version}"

# 2) Increase version number

# Build array from version string.

# shellcheck disable=SC2206
a=( ${version//./ } )

# Increment version numbers as requested.

if [ -z "${a[0]}" ]
then
  a[0]=0
fi

if [ -z "${a[1]}" ]
then
  a[1]=0
fi

if [ -z "${a[2]}" ]
then
  a[2]=0
fi

if [ -n "${patch}" ]
then
  ((a[2]++))
fi

if [ -n "${minor}" ]
then
  ((a[1]++))
  a[2]=0
fi

if [ -n "${major}" ]
then
  ((a[0]++))
  a[1]=0
  a[2]=0
fi

echo "Major: ${a[0]}"
echo "Minor: ${a[1]}"
echo "Patch: ${a[2]}"
next_version=$(addPrefix "${a[0]}.${a[1]}.${a[2]}")

tagMsg="${commitMsg:-$msg $next_version}"

# If its a dry run, just display the new release version number
if [ -n "${noexec}" ]
then
  echo "Tag message: $tagMsg"
  echo "Next version tag: $next_version"
  cmd="echo git"
else
  cmd="git"
fi

# If a command fails, exit the script
set -e

# Push master
${cmd} checkout "${branch}"
${cmd} pull --rebase origin "${branch}" || exit 1
${cmd} push origin "${branch}"

# 3) Add git tag
echo "Add git tag $next_version with message: ${tagMsg}"
${cmd} tag -a "${next_version}" -m "${tagMsg}"

# 4) Push the new tag

echo "Push the tag"
${cmd} push --tags origin "${branch}"

echo "Release done: $next_version"

popd
