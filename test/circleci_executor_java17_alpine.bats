#!/usr/bin/env bats
# shellcheck disable=SC2076

@test "evaluate installed package versions" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge apk -v info"
#  echo "# ${output}" >&3
#  [[ "${output}" =~ "libintl-0.21-r0" ]]
  [[ "${output}" =~ "openjdk17-jre-17.0.0_p35-r1" ]]
  [[ "${output}" =~ "openjdk17-jdk-17.0.0_p35-r1" ]]
  [[ "${output}" =~ "openjdk17-17.0.0_p35-r1" ]]
  [[ "${output}" =~ "openjdk16-jre-16.0.2_p7-r0" ]]
  [[ "${output}" =~ "openjdk16-jdk-16.0.2_p7-r0" ]]
  [[ "${output}" =~ "openjdk16-16.0.2_p7-r0" ]]
  [[ "${output}" =~ "openjdk11-jre-11.0.11_p9-r0" ]]
  [[ "${output}" =~ "openjdk11-jdk-11.0.11_p9-r0" ]]
  [[ "${output}" =~ "openjdk11-11.0.11_p9-r0" ]]
  [[ "${output}" =~ "shellcheck-0.7.1-r2" ]]
  [[ "${output}" =~ "py3-pip-20.3.4-r1" ]]
  [[ "${output}" =~ "colordiff-1.0.19-r0" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge python3 --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "3.9.5" ]]
}

@test "pip version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge pip --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "20.3.4" ]]
}

@test "shellcheck version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge shellcheck --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "0.7.1" ]]
}

@test "java version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge java -version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "17" ]]
}

@test "spectral version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge spectral --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "6.1.0" ]]
}

@test "hadolint version" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge hadolint --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "2.7.0" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-executor-java17-alpine-edge pip list --format json"
  echo "# ${output}" >&3
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"20.3.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"cookiecutter\", \"version\": \"1.7.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"mkdocs\", \"version\": \"1.2.2\"}" ]]
}
