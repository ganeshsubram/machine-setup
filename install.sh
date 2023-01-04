#!/bin/bash
sudo apt-get update
sudo apt-get install fzf -y
sudo apt-get install libnotify-bin -y
sudo apt-get install beep -y
sudo apt-get install zip unzip -y
sudo apt-get install silversearcher-ag -y
sudo apt-get install tmux -y
sudo apt-get autoremove -y

# system
cp ~/machine-setup/.bash_aliases ~/.bash_aliases
cp ~/machine-setup/.bashrc ~/.bashrc
source ~/.bashrc

# git
git config --global user.email "ganeshsubram1@gmail.com"
git config --global user.name "Ganesh Subramaniam"
cp ~/machine-setup/.gitignore.txt ~/.gitignore

# tmux - don't forget to run prefix + I to install the plugins!
cp ~/machine-setup/.tmux.conf ~/.
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
source ~/.bashrc
