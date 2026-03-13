# zsh-aws

A Zsh plugin for [aws-vault](https://github.com/99designs/aws-vault) integration with per-window AWS profile support in tmux.

## Features

- Automatic AWS credential export using aws-vault
- Per-window AWS profile support via tmux `@aws_profile` option
- Falls back from `AWS_PROFILE` to `AWS_VAULT` environment variable
- Skips credential export when session is already active

## Requirements

- [aws-vault](https://github.com/99designs/aws-vault) - AWS credential manager
- [tmux](https://github.com/tmux/tmux) (optional) - for per-window profile support

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

Set the `AWS_PROFILE` environment variable to your desired AWS profile name:

```zsh
export AWS_PROFILE="your-aws-profile"
```

### Tmux Integration

Set the `@aws_profile` window option to use per-window AWS profiles:

```tmux
set-window-option @aws_profile "your-window-specific-profile"
```

Set a default profile for all new windows in `.tmux.conf`:

```tmux
set-window-option -g @aws_profile "your-default-profile"
```

### Keychain Settings

To prevent frequent login popups, increase the `aws-vault` keychain timeout:

```bash
security set-keychain-settings -t 25200 ~/Library/Keychains/aws-vault.keychain-db
```

## Behavior

The plugin runs automatically when your shell starts:

1. Falls back to `AWS_VAULT` if `AWS_PROFILE` is not set
2. If still unset and inside tmux, reads the `@aws_profile` window option
3. Exports credentials via `aws-vault` if a profile is set and no active session exists

## Directory Structure

```
zsh-aws/
├── zsh-aws.plugin.zsh   # Main plugin entry point
├── README.md
└── LICENSE
```

## License

MIT License - see [LICENSE](./LICENSE) for details.
