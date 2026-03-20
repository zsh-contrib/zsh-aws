# zsh-aws

> AWS credential management for Zsh — per-window profiles in tmux, automatic export via aws-vault.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![test](https://github.com/zsh-contrib/zsh-aws/actions/workflows/test.yml/badge.svg)](https://github.com/zsh-contrib/zsh-aws/actions/workflows/test.yml)

Stop re-exporting credentials every time you switch AWS accounts. `zsh-aws` hooks into aws-vault to load the right profile automatically — from `AWS_PROFILE`, `AWS_VAULT`, or a per-window tmux option — so your shell is always authenticated before you type the first command.

## Requirements

- [aws-vault](https://github.com/99designs/aws-vault) (`aws-vault`)
- [tmux](https://github.com/tmux/tmux) (`tmux`) — optional, for per-window profile support

**macOS (Homebrew):**

```bash
brew install aws-vault tmux
```

**Nix:**

```bash
nix profile install nixpkgs#awscli2 nixpkgs#tmux
```

## Installation

### Using zinit

```zsh
zinit load zsh-contrib/zsh-aws
```

### Using sheldon

```toml
[plugins.zsh-aws]
github = "zsh-contrib/zsh-aws"
```

### Manual

```zsh
git clone https://github.com/zsh-contrib/zsh-aws.git ~/.zsh/plugins/zsh-aws
source ~/.zsh/plugins/zsh-aws/zsh-aws.plugin.zsh
```

## Configuration

### Environment Variable

Set `AWS_PROFILE` to your desired AWS profile name:

```zsh
export AWS_PROFILE="your-aws-profile"
```

### Tmux Integration

Set the `@aws_profile` window option for per-window profiles:

```tmux
set-window-option @aws_profile "your-window-specific-profile"
```

Set a default for all new windows in `.tmux.conf`:

```tmux
set-window-option -g @aws_profile "your-default-profile"
```

### Keychain Settings

To reduce frequent login prompts, increase the aws-vault keychain timeout:

```bash
security set-keychain-settings -t 25200 ~/Library/Keychains/aws-vault.keychain-db
```

## Behavior

The plugin runs automatically when your shell starts:

1. Falls back to `AWS_VAULT` if `AWS_PROFILE` is not set
2. If still unset and inside tmux, reads the `@aws_profile` window option
3. Exports credentials via `aws-vault` if a profile is set and no active session exists

## The zsh-contrib Ecosystem

| Repo | What it provides |
|------|-----------------|
| **zsh-aws** ← you are here | AWS credential management with aws-vault and tmux |
| [zsh-eza](https://github.com/zsh-contrib/zsh-eza) | eza with Catppuccin and Rose Pine theming |
| [zsh-fzf](https://github.com/zsh-contrib/zsh-fzf) | fzf with Catppuccin and Rose Pine theming |
| [zsh-op](https://github.com/zsh-contrib/zsh-op) | 1Password CLI with secure caching and SSH key management |
| [zsh-tmux](https://github.com/zsh-contrib/zsh-tmux) | Automatic tmux window title management |
| [zsh-vivid](https://github.com/zsh-contrib/zsh-vivid) | vivid LS_COLORS generation with theme support |

## License

[MIT](LICENSE) — Copyright (c) 2025 zsh-contrib

<!-- markdownlint-disable-file MD013 -->
