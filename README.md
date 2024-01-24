# Machine-Setup

## Steps

1. Clone in your **home** directory:

    ```bash
    git clone git@github.com:ganeshsubram/machine-setup.git ~/machine-setup
    ```

3. If you're not Ganesh, set line 41 of `~/machine/setup/.bashrc ` to your own GitHub username:

    ```bash
    github_user=ganeshsubram
    ```

4. Enter the repo and install the tools using the provision script:

    ```bash
    cd ~/machine-setup
    ./provision.sh
    ```

5. Open a tmux session:

    ```bash
    tmux
    ```

6. Install tmux plugins with `ctrl + a` then `shift + i`, you should see the pane refresh with the following prompt:

    ```txt
    TMUX environment reloaded.
    Done, press ENTER to continue.
    ```

7. Press `enter` to exit out of the prompt and back to your tmux terminal.

8. Update sudoers so your account doesn't need to enter a password for sudo every time (quality of life + tmux plugins run some sudo commands):

    a. Enter sudoers with:

    ```bash
    sudo visudo
    ```

    b. Append the following line to the resulting file editor (replace `ganesh` with whatever your user is):

    ```txt
    ganesh ALL=(ALL) NOPASSWD:ALL
    ```

9. [Optional] Update `/etc/netplan/01-network-manager-all.yaml` to rename your network interfaces names to something that actually makes sense.

    a. List all your network interfaces and their physical attributes with:

    ```bash
    lshw -C network
    ```

    b. Note the MAC addresses of each interface

    c. Update `/etc/netplan/01-network-manager-all.yaml` with the following with your corresponding MAC addresses + new names:

    ```yaml
    # Let NetworkManager manage all devices on this system
    network:
    version: 2
    renderer: NetworkManager
    ethernets:
        # XPS integrated wlan
        # original-name: wlp0s20f3
        wlan0:
        dhcp4: true
        match:
            macaddress: 74:04:f1:53:78:7a
        set-name: wlan0
        # Gaming Station ethernet
        # original-name: enx00056b00a5d4
        eth0:
        dhcp4: true
        match:
            macaddress: 00:05:6b:00:a5:d4
        set-name: eth0
    ```

    d. Apply the changes with:

    ```bash
    sudo netplan apply
    ```

    e. If you get the following error:

    ```log
    WARNING: systemd-networkd is not running, output will be incomplete.

    Failed to reload network settings: No such file or directory
    Falling back to a hard restart of systemd-networkd.service
    ```

    just run the `sudo netplan apply` again and it should succeed without that error.

## Command-line Usage

- `ctrl + r` for fzf fuzzy command history searching
- `ag` for silver searcher

## Git Usage

- Entering a git repo should automatically show the current branch name after the current path
- `branch branch_name` to automatically create `username/branch_name`
- `gs` for `git status`
- `gb` for `git branch`
- `gd` for `git diff`
- `gp` for `git push`
- `gpf` for `git push -f`
- `gal` for `git add --all`
- `cane` for `git commit --amend --no-edit`
- `gco` for `git checkout master`
- `gcom` for `git checkout main`
- `gpom` for `git pull origin main`
- `grbi <branch>` for `git rebase -i main <branch>`


## Tmux Usage

### Copy/Paste

- Press and hold `shift`, highlight text with mouse, then use either `ctrl + shift + c` or `right-click + copy` to copy to system clipboard
- Use `ctrl + shift + v` to paste from system clipboard

- Use `ctrl + [` and then click/highlight text to copy to tmux buffer
- Use `right-click` + `l` to copy line into tmux buffer
- Use `right-click` + various `copy` options in drop down menu to copy to tmux buffer.
- Use `ctrl + ]` to paste from tmux buffer

### Panes

- Use `ctrl + |` to split the tmux pane vertically.
- Use `ctrl + -` or `ctrl + _` to split the tmux pane horizontally.
- Use `alt + <arrow key>` to navigate between tmux panes.
- Use `ctrl + a + q` to display tmux pane identifiers.

### Pane Widgets

To edit the widgets at the bottom of the pane, modify the following line in `~/machine-setup/tmux/main/plugins.tmux`:

```tmux
set -g @dracula-plugins "git battery cpu-info ram-usage gpu-info time"
```

and replace with your desired widgets in the quotes. The full list of widgets you can enter is:

- `battery`
- `cpu-info`
- `git`
- `gpu-info`
- `ram-usage`
- `disk-usage`
- `network`
- `network-rate`
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
