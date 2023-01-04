# Tmux plugins
set -g @plugin 'tmux-plugins/tpm'
# set -g @plugin 'christoomey/vim-tmux-navigator'

set -g @plugin 'dracula/tmux'
set -g @dracula-plugins "cpu-usage gpu-usage ram-usage"
# available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, network-ping, weather, time
set -g @dracula-plugins "git battery cpu-usage ram-usage gpu-usage time"
