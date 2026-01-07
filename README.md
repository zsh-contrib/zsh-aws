# zsh-aws

A `zsh` plugin for simplified AWS profile management, with `aws-vault` and
`tmux` integration.

## Features

- Automatically exports AWS credentials using `aws-vault` for the specified `$AWS_PROFILE`.
- Seamlessly integrates with `tmux`: if `$AWS_PROFILE` is not set, it uses the `@AWS_PROFILE` option from the current `tmux` window.

## Requirements

- [zsh](https://www.zsh.org/)
- [aws-vault](https://github.com/99designs/aws-vault)
- [tmux](https://github.com/tmux/tmux) (optional, for profile detection from `tmux` window)

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

Clone this repository and source the plugin file in your `.zshrc`:

```zsh
git clone https://github.com/zsh-contrib/zsh-aws.git ~/.zsh/plugins/zsh-aws
source ~/.zsh/plugins/zsh-aws/zsh-aws.plugin.zsh
```

## Behavior

The plugin's behavior is determined by the environment it runs in:

**If `$AWS_PROFILE` is set**: The plugin will use `aws-vault` to export
temporary credentials for the specified profile into your shell session.

```sh
export AWS_PROFILE="my-corp-profile"
# zsh-aws will automatically run `aws-vault export my-corp-profile`
```

**If `$AWS_PROFILE` is NOT set, but in a `tmux` session**: The plugin checks
for a `tmux` window option named `@AWS_PROFILE`. - If `@AWS_PROFILE` is set for
the window, its value is used as the `AWS_PROFILE`. - `aws-vault` then exports
credentials for that profile.

This allows you to have different AWS profiles active in different `tmux` windows.

## Configuration

If you want to prevent often login popups, you should change the `aws-vault`
keychain:

```bash
security set-keychain-settings -t 25200 ~/Library/Keychains/aws-vault.keychain-db
```

### Environment Variable

Set the `AWS_PROFILE` environment variable to your desired AWS profile name.

```sh
# in your .zshrc or on the command line
export AWS_PROFILE="your-aws-profile"
```

### Tmux Integration

To use the `tmux` integration, set the `@AWS_PROFILE` window option. You can do
this in your `.tmux.conf` or manually per window.

**Set option for a specific window:**

From within `tmux` (press `Ctrl-b` then `:`):

```tmux
set-window-option @AWS_PROFILE "your-window-specific-profile"
```

**Set a default profile for all new windows in `.tmux.conf`:**

```tmux
# ~/.tmux.conf
set-window-option -g @AWS_PROFILE "your-default-profile"
```

## License

MIT License.
