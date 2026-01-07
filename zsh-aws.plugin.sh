#!/usr/bin/env zsh

# If AWS_PROFILE is not set, try to get it from tmux
if ! (($ + AWS_PROFILE)) && [[ -n "$TMUX" ]]; then
  TMUX_AWS_PROFILE=$(tmux show-window-options -v @AWS_PROFILE 2>/dev/null)
  if [[ -n "$TMUX_AWS_PROFILE" ]]; then
    export AWS_PROFILE=$TMUX_AWS_PROFILE
  fi
fi

# AWS vault export
if (($ + AWS_PROFILE)); then
  eval "$(aws-vault export $AWS_PROFILE --format export-env)"
fi
