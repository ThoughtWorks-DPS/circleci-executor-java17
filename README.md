
<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png" width=350/>
	</p>
  <h3>DPS Convenience Images</h3>
  <h1>twdps/circleci-executor-java17</h1>
  <a href="https://app.circleci.com/pipelines/github/ThoughtWorks-DPS/circleci-executor-java17"><img src="https://circleci.com/gh/ThoughtWorks-DPS/circleci-executor-java17.svg?style=shield"></a> <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/ThoughtWorks-DPS/circleci-executor-java17"></a>
</div>
<br />

With inspiration from the CircleCI convenience images, `twdps/circleci-executor-java17` maintains both alpine and buster-slim variants with self-hosted runners in mind.
As the name suggests, this image is designed to serve as a starter image for building a use-tailored CircleCI [remote docker executor](https://circleci.com/docs/2.0/custom-images/#section=configuration).

This image contains the minimum packages required to operate a Java17 build on CircleCI.

_difference with cimg libraries._
Enterprise settings often require specific security and configuration testing.
The twdps series of convenience images includes common sdlc security practices, including CIS-benchmark testing.
The Alpine image is expected to not have any cve issues.

**Other images in this series**

twdps/circleci-base-image  
twdps/circleci-executor-builder  
twdps/circleci-infra-aws
twdps/circleci-remote-docker

## Table of Contents

- [Getting Started](#getting-started)
- [What is included in the image](#what-is-included-in-the-image)
- [Development](#development)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)

## Getting Started

This image intended to be used as a build executor for Java17 builds, or as base for executors that need additional functionality.

For example:

```Dockerfile
FROM twdps/circleci-executor-java17:alpine-0.1.2  

ENV NODE_VERSION=12.16.3

RUN curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
	sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
	rm node.tar.xz && \
	sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs
```

The tag `alpine-0.1.2` indicates that the version of the base image used will be the 0.1.2 Alpine release.

See how tags work below for more information.

## What is Included in the Image

This image is maintained with both an Alpine and Debian Linux based distribution and contains the minimum requirements needed to be used as a Java17 executor on CircleCI:

- shellcheck
- py3-pip
- colordiff
- libintl
- cookiecutter
- mkdocs
- spectral

_See CHANGES.md for current versions and .snyk for current vuln recommandations_

### Tagging Scheme

This image has the following tagging scheme:

```
twdps/circleci-executor-java17:<alpine|slim>-edge
twdps/circleci-executor-java17:<alpine|slim>-stable
twdps/circleci-executor-java17:<alpine|slim>-X.Y.Z
```

`<X.Y.Z>` - Release version of the image, referred to by the Major.Minor.Patch version numbers
This is the recommended version for use in an executor Dockerfile.

`stable` - generic tag that always points to the latest, monthly release image.
For projects that want a decent level of stability while receiving all software updates and recommended security patches.
Security patches can sometimes include pre-release or release candidate versions of packages.

`edge` - is the latest development of the Base image.
Built from the `HEAD` of the `main` branch.
Intended to be used as a testing version of the image with the most recent changes however not guaranteed to be all that stable.

### Publishing Official Images (for Maintainers only)

Git push will trigger the dev-build pipeline.
In addition to the tests performed in testlocal.sh, a snyk scan is done to expose any known vulnerabilities.

To create a release version, simply tag HEAD with the release version format `X.Y.Z`
As a convenience, there is a script that will bump the latest release version and complete the tag/push process:

```bash
./scripts/release.sh -p
```

## Contributing

We encourage [issues](https://github.com/twdps/circleci-executor-java17/issues) and [pull requests](https://github.com/twdps/circleci-executor-java17/pulls) against this repository.
In order to value your time, here are some things to consider:

1. Intended to be the minimum configuration necessary for an alpine or debian based image to be successfully launched by circleci as a Java16 build executor and specifically does not include any other packages.
   As such, the way to use the image is in the `.circleci/config.yml` file in your repository.
   ```yaml
   jobs:
     build:
       docker:
         - image: docker.pkg.github.com/ThoughtWorks-DPS/circleci-executor-java17/circleci-executor-java17:{latest_version}
           ...
   ```
2. This image may also be the base for further customization, should you need additional tooling support.
As such, the way to use the image is in the `FROM twdps/circleci-executor-java17:{version}` statement of your Dockerfile.
3. PRs are welcome.
Given the role of this image as a building block in building CircleCI remote docker executors, it is expected that PRs or Issue will be related to bugs or compatibility issues.
PR's to include additional packages will only be considered where necessary to continue supporting Alpine linux as a Java17 build executor.

## Additional Resources

- [CircleCI Docs](https://circleci.com/docs/)
- [CircleCI Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration)  
