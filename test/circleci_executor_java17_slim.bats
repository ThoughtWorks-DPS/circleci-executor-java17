#!/usr/bin/env bats
# shellcheck disable=SC2076

@test "evaluate installed package versions" {
  run bash -c "docker exec circleci-executor-java17-slim-edge apt list --installed"
  echo "# ${output}" >&3
  [[ "${output}" =~ "openjdk-17-jdk/now 17.0.1+12-1" ]]
  [[ "${output}" =~ "shellcheck/now 0.7.2-2+b1" ]]
  [[ "${output}" =~ "colordiff/now 1.0.18-1.1" ]]
  [[ "${output}" =~ "python3.9/now 3.9.7-2" ]]
  [[ "${output}" =~ "python3-pip/now 20.3.4-4" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge python3 --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "3.9.7" ]]
}

@test "pip version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge pip --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "20.3.4" ]]
}

@test "shellcheck version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge shellcheck --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "0.7.2" ]]
}

@test "java version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge java -version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "17.0.1+12-Debian-1" ]]
}

@test "spectral version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge spectral --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "6.1.0" ]]
}

@test "hadolint version" {
  run bash -c "docker exec circleci-executor-java17-slim-edge hadolint --version"
  echo "# ${output}" >&3
  [[ "${output}" =~ "2.7.0" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-executor-java17-slim-edge pip list --format json"
  echo "# ${output}" >&3
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"20.3.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"cookiecutter\", \"version\": \"1.7.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"mkdocs\", \"version\": \"1.2.2\"}" ]]
}
