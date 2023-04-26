# Tmux plugins

# Tmux Plugin Manger
set -g @plugin 'tmux-plugins/tpm'

# Dracula
set -g @plugin 'dracula/tmux'
# available dracula widgets:
#  battery, cpu-usage, git, gpu-info, ram-usage, network, network-bandwidth, network-ping, weather, time
set -g @dracula-plugins "git ram-usage cpu-info gpu-info time battery"
set -g @dracula-refresh-rate 1
