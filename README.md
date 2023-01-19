# Machine-Setup

## Steps

1. Clone in your home directory:

    ```bash
    git clone git@github.com:ganeshsubram/machine-setup.git
    ```

2. Enter the repo and install the tools using the provision script:

    ```bash
    ./provision.sh
    ```

3. Open a tmux session:

    ```bash
    tmux
    ```

4. Install tmux plugins with `ctrl + a` then `shift + i`, you should see the pane refresh with the following prompt:

    ```txt
    TMUX environment reloaded.
    Done, press ENTER to continue.
    ```

5. Press `enter` to exit out of the prompt and back to your tmux terminal.


## Command-line Usage

- `ctrl + r` for fzf fuzzy command history searching
- `ag` for silver searcher

## Git Usage

- Entering a git repo should automatically show the current branch name after the current path
- `gs` for `git status`
- `gd` for `git diff`
- `gco` for `git checkout master`
- `gcom` for `git checkout main`
- `gal` for `git add --all`
- `cane` for `git commit --amend --no-edit`

## Tmux Usage

### Panes

- Use `ctrl + |` to split the tmux pane vertically.
- Use `ctrl + -` or `ctrl + _` to split the tmux pane horizontally.
- Use `alt + <arrow key>` to navigate between tmux panes.
- Use `ctrl + a + q` to display tmux pane identifiers.

### Pane Widgets

To edit the widgets at the bottom of the pane, modify the following line in `~/machine-setup/tmux/main/plugins.tmux`:

```tmux
set -g @dracula-plugins "git battery cpu-usage ram-usage gpu-usage time"
```

and replace with your desired widgets in the quotes. The full list of widgets you can enter is:

- `battery`
- `cpu-usage`
- `git`
- `gpu-usage`
- `ram-usage`
- `network`
- `network-bandwidth`
- `network-ping`
- `time`
- `weather`

To apply the changes, use the command `tmux_refresh` and you should see your changes applied instantly.

### Sessions

- Use `tmux ls` to see existing tmux sessions.
- Use `tmux attach -t <session id>` to attach to an existing tmux session.
- Use `ctrl + a` then `d` to detach from the tmux session.
- Use `ctrl + a` then `:` and `kill-session` to kill the current tmux session.
- Use `tmux kill-session -t <session id>` to kill a specific tmux session from the command line.

### Plugins

Adding a plugin:

1. Add the plugin config to `~/machine-setup/tmux/main/plugins.conf`
2. Refresh tmux with `tmux_refresh` (aliased to `tmux source ~/.tmux.conf`)
3. Enter a new tmux session with `tmux`
4. Install the plugin with `ctrl + a` then `shift + i`

Removing a plugin:

1. Remove/comment out the plugin from `~/machine-setup/tmux/main/plugins.conf`
2. Enter a tmux session (existing one is fine)
3. Uninstall the plugin with `ctrl + a` + `alt + u`
