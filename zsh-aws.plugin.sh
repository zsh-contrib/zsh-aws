#!/usr/bin/env zsh

# Step 0: Fall back to AWS_VAULT when AWS_PROFILE is unset.
AWS_PROFILE="${AWS_PROFILE:-$AWS_VAULT}"

# Step 1: Determine AWS_PROFILE from tmux if still unset.
# If AWS_PROFILE is unset or empty, and we're in tmux, try to get it from there.
if [[ -z "$AWS_PROFILE" ]] && [[ -n "$TMUX" ]]; then
  TMUX_AWS_PROFILE=$(tmux show-window-options -v @aws_profile 2>/dev/null)
  if [[ -n "$TMUX_AWS_PROFILE" ]]; then
    export AWS_PROFILE=$TMUX_AWS_PROFILE
  fi
fi

# Step 2: Export credentials at startup if a profile is set.
# Use --no-prompt to avoid hanging the shell.
if [[ -n "$AWS_PROFILE" ]] && [[ -z "$AWS_SESSION_TOKEN" ]]; then
  eval "$(aws-vault export $AWS_PROFILE --format export-env)"
fi
