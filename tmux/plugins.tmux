# Tmux plugins

# Tmux Plugin Manger
set -g @plugin 'tmux-plugins/tpm'

# Dracula
set -g @plugin 'dracula/tmux'
# available dracula widgets:
#  battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, network-ping, weather, time
set -g @dracula-plugins "git ram-usage cpu-usage gpu-usage time battery"
set -g @dracula-refresh-rate 1
