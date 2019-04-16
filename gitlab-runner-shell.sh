#!/bin/sh

RUNNER_NODE_NAME="example.com"
RUNNER_REGISTRATION_TOKEN=""
RUNNER_DESCRIPTION="$RUNNER_NODE_NAME runner"

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt install gitlab-runner

# Register GitLab runner
sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.com/" \
  --registration-token "$RUNNER_REGISTRATION_TOKEN" \
  --executor "shell" \
  --description "$RUNNER_DESCRIPTION" \
  --tag-list "$RUNNER_NODE_NAME" \
  --run-untagged \
  --locked="false"

sudo usermod -aG docker gitlab-runner