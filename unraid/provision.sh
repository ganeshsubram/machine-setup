#!/bin/bash

#
# bash
#
echo
echo "Setting up bash..."
echo

rm ~/.bash_aliases
rm ~/.bashrc
ln -s ~/machine-setup/.bash_aliases ~/.bash_aliases
ln -s ~/machine-setup/.bashrc ~/.bashrc
source ~/.bashrc

#
# git - requires auth so do this first
#
echo
echo "Setting up git..."
echo

git config --global user.email "ganeshsubram1@gmail.com"
git config --global user.name "Ganesh Subramaniam"
git config --global fetch.jobs $(nproc)
cp ~/machine-setup/.gitignore.txt ~/.gitignore

#
# tmux
#
echo
echo "Setting up Tmux..."
echo

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

echo
echo "Setting up Docker..."
echo

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
# VS Code
#
echo
echo "Setting up VS Code..."
echo

# Define the target directory and symlink
VSCODE_SERVER_TARGET_DIR="/mnt/user/appdate/vscode-server"
VSCODE_SERVER_SYMLINK="/root/.vscode-server"

# Check if the symlink already exists
if [ -L "$VSCODE_SERVER_SYMLINK" ]; then
    echo ".vscode-server already exists. Overriding"
    rm -f "$VSCODE_SERVER_SYMLINK"
elif [ -e "$VSCODE_SERVER_SYMLINK" ]; then
    echo "A file or directory already exists at $SYMLINK, but it is not a symlink. Removing it."
    rm -rf "$VSCODE_SERVER_SYMLINK"
fi

# Create the symlink
ln -s "$VSCODE_SERVER_TARGET_DIR" "$VSCODE_SERVER_SYMLINK"
echo "Symlink created: $VSCODE_SERVER_SYMLINK -> $VSCODE_SERVER_TARGET_DIR"

#
#
# Clean up
#
source ~/.bashrc
