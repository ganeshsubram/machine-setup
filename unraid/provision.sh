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
git config --global user.email "ganeshsubram1@gmail.com"
git config --global user.name "Ganesh Subramaniam"
git config --global fetch.jobs $(nproc)
cp ~/machine-setup/.gitignore.txt ~/.gitignore

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
