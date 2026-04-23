# Changelog

## [0.1.0](https://github.com/zsh-contrib/zsh-aws/compare/v0.0.1...v0.1.0) (2026-04-23)


### Features

* add support for tmux @AWS_PROFILE ([9cff773](https://github.com/zsh-contrib/zsh-aws/commit/9cff77311bc9e9725d1692962a5c2b465455ea10))
* fall back to AWS_VAULT when AWS_PROFILE is unset ([d2d743b](https://github.com/zsh-contrib/zsh-aws/commit/d2d743b401f75d96fecf18702f3ed89e07d69fc9))


### Bug Fixes

* add AWS_SESSION_TOKEN check to prevent re-exporting credentials ([50cf078](https://github.com/zsh-contrib/zsh-aws/commit/50cf078b2a0f79ebd9d6d1597c1d8aefcd59ae7a))
* add postCreateCommand to restore nix volume permissions ([dbbf7ed](https://github.com/zsh-contrib/zsh-aws/commit/dbbf7ed3d236c1776bcdb4761de4f336cc4a04b5))
* prevent hanging by running aws-vault only in AWS_PROFILE ([6be46a4](https://github.com/zsh-contrib/zsh-aws/commit/6be46a449852986a9948bf7a101d0dfd30148b22))
* **zsh:** correct tmux aws profile option case ([1e842ba](https://github.com/zsh-contrib/zsh-aws/commit/1e842ba0aea6f81e24ea4c569140f51f6c644c10))
