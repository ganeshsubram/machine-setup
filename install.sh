#!/bin/bash
sudo apt-get update
sudo apt-get install fzf -y
sudo apt-get install libnotify-bin -y
sudo apt-get install beep -y
sudo apt-get install zip unzip -y

# tmux
cp ~/Machine-Setup/.tmux.conf ~/.
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
