#!/bin/bash

sudo apt update -y

# tools
sudo apt install -y \
    beep \
    fzf \
    gpustat \
    ifupdown \
    intel-gpu-tools \
    libnotify-bin \
    net-tools \
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

# wireshark
# sudo add-apt-repository -y ppa:wireshark-dev/stable
# sudo apt-get update -y
# sudo apt-get install -y wireshark
# sudo dpkg-reconfigure wireshark-common
# sudo adduser $USER wireshark
# sudo usermod -a -G wireshark "$USER"

# bash
rm ~/.bash_aliases
rm ~/.bashrc
ln -s ~/machine-setup/.bash_aliases ~/.bash_aliases
ln -s ~/machine-setup/.bashrc ~/.bashrc
source ~/.bashrc

# git
git config --global user.email "ganeshsubram1@gmail.com"
git config --global user.name "Ganesh Subramaniam"
cp ~/machine-setup/.gitignore.txt ~/.gitignore

# tmux
rm -rf ~/.tmux/
rm -rf ~/.tmux.conf
sudo apt install -y tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/machine-setup/tmux/.tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh
rm -rf ~/.tmux/plugins/tmux/scripts
ln -s ~/machine-setup/tmux/dracula/scripts ~/.tmux/plugins/tmux/

sudo apt autoremove -y
