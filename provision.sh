#!/bin/bash

sudo apt-get update -y

# tools
sudo apt install -y \
    beep \
    fzf \
    libnotify-bin \
    silversearcher-ag \
    zip unzip

# bluetooth codecs
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo apt install -y \
    libldac \
    pulseaudio-modules-bt \
    libavcodec-extra58 \
    libfdk-aac1 \
    bluez \
    pulseaudio \
    pavucontrol
pulseaudio -k
systemctl --user enable pulseaudio
systemctl --user start pulseaudio

# bash
cp ~/machine-setup/.bash_aliases ~/.bash_aliases
cp ~/machine-setup/.bashrc ~/.bashrc
source ~/.bashrc

# git
git config --global user.email "ganeshsubram1@gmail.com"
git config --global user.name "Ganesh Subramaniam"
cp ~/machine-setup/.gitignore.txt ~/.gitignore

# tmux
# (don't forget to run prefix + I to install the plugins!)
sudo apt install -y tmux
cp ~/machine-setup/.tmux.conf ~/.
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
source ~/.bashrc

sudo apt-get autoremove -y
