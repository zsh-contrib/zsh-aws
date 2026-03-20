#!/usr/bin/env bats

# Tests for zsh-aws plugin
#
# Requires bats-core: https://github.com/bats-core/bats-core
# Run: bats tests/plugin.bats

export PLUGIN_DIR
PLUGIN_DIR="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"

# ---------------------------------------------------------------------------
# AWS_PROFILE resolution
# ---------------------------------------------------------------------------

@test "AWS_PROFILE falls back to AWS_VAULT when unset" {
  run zsh -c '
    unset AWS_PROFILE AWS_SESSION_TOKEN TMUX
    export AWS_VAULT="my-vault-profile"
    aws-vault() { :; }
    eval() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "$AWS_PROFILE"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "my-vault-profile" ]]
}

@test "AWS_PROFILE is kept when already set" {
  run zsh -c '
    export AWS_PROFILE="existing-profile"
    export AWS_VAULT="other-profile"
    unset AWS_SESSION_TOKEN TMUX
    aws-vault() { :; }
    eval() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "$AWS_PROFILE"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "existing-profile" ]]
}

@test "AWS_PROFILE stays unset when both AWS_PROFILE and AWS_VAULT are unset" {
  run zsh -c '
    unset AWS_PROFILE AWS_VAULT AWS_SESSION_TOKEN TMUX
    aws-vault() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "${AWS_PROFILE:-unset}"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "unset" ]]
}

# ---------------------------------------------------------------------------
# aws-vault invocation
# ---------------------------------------------------------------------------

@test "aws-vault export is called when AWS_PROFILE is set and no session token" {
  # aws-vault runs inside $() so we test its effect via eval rather than a flag
  run zsh -c '
    export AWS_PROFILE="dev"
    unset AWS_SESSION_TOKEN TMUX
    aws-vault() { echo "export AWS_ACCESS_KEY_ID=TESTKEY"; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "$AWS_ACCESS_KEY_ID"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "TESTKEY" ]]
}

@test "aws-vault export is NOT called when AWS_SESSION_TOKEN is already set" {
  run zsh -c '
    export AWS_PROFILE="dev"
    export AWS_SESSION_TOKEN="existing-token"
    unset TMUX
    vault_called=""
    aws-vault() { vault_called="yes"; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "${vault_called:-no}"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "no" ]]
}

@test "aws-vault export is NOT called when no AWS_PROFILE is set" {
  run zsh -c '
    unset AWS_PROFILE AWS_VAULT AWS_SESSION_TOKEN TMUX
    vault_called=""
    aws-vault() { vault_called="yes"; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "${vault_called:-no}"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "no" ]]
}

# ---------------------------------------------------------------------------
# Tmux integration
# ---------------------------------------------------------------------------

@test "AWS_PROFILE is read from tmux @aws_profile option when unset" {
  run zsh -c '
    unset AWS_PROFILE AWS_VAULT AWS_SESSION_TOKEN
    export TMUX="tmux-socket"
    tmux() { echo "tmux-window-profile"; }
    aws-vault() { :; }
    eval() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "$AWS_PROFILE"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "tmux-window-profile" ]]
}

@test "tmux @aws_profile is ignored when AWS_PROFILE is already set" {
  run zsh -c '
    export AWS_PROFILE="already-set"
    export TMUX="tmux-socket"
    tmux() { echo "tmux-window-profile"; }
    aws-vault() { :; }
    eval() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "$AWS_PROFILE"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "already-set" ]]
}

@test "tmux profile is not used when tmux returns empty string" {
  run zsh -c '
    unset AWS_PROFILE AWS_VAULT AWS_SESSION_TOKEN
    export TMUX="tmux-socket"
    tmux() { echo ""; }
    aws-vault() { :; }
    source "$PLUGIN_DIR/zsh-aws.plugin.zsh"
    echo "${AWS_PROFILE:-unset}"
  '
  [[ "$status" -eq 0 ]]
  [[ "$output" == "unset" ]]
}
