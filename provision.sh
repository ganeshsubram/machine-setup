#!/bin/bash

#
# bash
#
rm ~/.bash_aliases
rm ~/.bashrc
ln -s ~/machine-setup/.bash_aliases ~/.bash_aliases
ln -s ~/machine-setup/.bashrc ~/.bashrc
source ~/.bashrc

#
# git - requires auth so do this first
#
sudo apt install gh -y
gh auth login
gh extension install davidraviv/gh-clean-branches
git config --global user.email "ganesh@glydways.com"
git config --global user.name "Ganesh Subramaniam"
git config --global fetch.jobs $(nproc)
cp ~/machine-setup/.gitignore.txt ~/.gitignore

#
# apt-installs - do them all here so we only have to enter sudo creds once :)
#
sudo apt update -y
sudo apt-get update -y

packages=(
    arp-scan
    curl
    ethtool
    fping
    fzf
    gpustat
    ifupdown
    inetutils-traceroute
    iperf3
    iproute2
    ipset
    iputils-ping
    iw
    less
    lm-sensors
    make
    net-tools
    openssh-server
    parted
    pciutils
    python3-pip
    rename
    renameutils
    rsync
    silversearcher-ag
    traceroute
    tshark
    tmux
    unzip
    usbutils
    vim
    vlan
    wget
    whois
    wireless-tools
    zip
    zsh
)

for pkg in "${packages[@]}"; do
    if ! sudo apt install -y "$pkg"; then
        echo "Failed to install $pkg, continuing..."
    fi
done

#
# networking tools
#
sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt-get install -y wireshark
sudo dpkg-reconfigure wireshark-common
sudo adduser $USER wireshark
sudo usermod -a -G wireshark "$USER"

#
# tmux
#
rm -rf ~/.tmux/
rm -rf ~/.tmux.conf
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/machine-setup/tmux/.tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh
rm -rf ~/.tmux/plugins/tmux/scripts
ln -s ~/machine-setup/tmux/dracula/scripts ~/.tmux/plugins/tmux/

#
# ssh
#
sudo systemctl start ssh
sudo systemctl enable ssh

#
# tailscale
#
curl -fsSL https://tailscale.com/install.sh | sh

#
# bluetooth codecs
#
# sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
# sudo apt install -y \
#     libldac \
#     pulseaudio-modules-bt \
#     libavcodec-extra58 \
#     libfdk-aac1 \
#     bluez \
#     pulseaudio \
#     pavucontrol
# pulseaudio -k
# systemctl --user enable pulseaudio
# systemctl --user start pulseaudio

#
# egpu switchers
#
# git clone https://github.com/karli-sjoberg/gswitch.git
# cd gswitch/
# sudo gswitch setup
#
# sudo snap install go --classic
# git clone git@github.com:hertg/egpu-switcher.git
# cd egpu-switcher
# make build -s
# sudo make install -s
# sudo egpu-switcher enable

#
# Docker
#

is_docker_installed() {
    command -v docker &> /dev/null
}

is_user_in_docker_group() {
    groups $USER | grep &>/dev/null '\bdocker\b'
}

if ! is_docker_installed; then
    echo "Docker is not installed. Proceeding with installation..."

    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh

    # Add the docker group if it does not exist
    if ! getent group docker > /dev/null; then
        sudo groupadd docker
    fi

    # Add the current user to the docker group
    sudo usermod -aG docker $USER
    newgrp docker

    echo "Docker installation and user configuration completed."
else
    echo "Docker is already installed."
fi

if ! is_user_in_docker_group; then
    echo "User $USER is not in the docker group. Adding the user to the group..."

    # Add the current user to the docker group
    sudo usermod -aG docker $USER
    newgrp docker

    echo "User $USER has been added to the docker group."
else
    echo "User $USER is already in the docker group."
fi

#
# Clean up
#
source ~/.bashrc
sudo apt autoremove -y
