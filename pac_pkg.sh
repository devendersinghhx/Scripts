#!/bin/bash

# Define an array of official repository packages to install
REPO_PACKAGES=(
    "curl"
    "stow"
    "fastfetch"
    "bat"
    "lua51"
    "luarocks"
    "vim"
    "neovim"
    "yazi"
    "zoxide"
    "zsh"
    "btop"
    "nvtop"
    "htop"
    "mpv" 
    "git"
    "github-cli"
    "tmux"
    "xclip"
    "ufw"
    "kitty"
    "keepassxc"
    "discover"
    "npm"
    "ffmpeg"
    "base-devel"
)

# Update package database and upgrade all packages
echo "Updating package database and upgrading all packages..."
sudo pacman -Syu --noconfirm

# Arrays to track installed and not installed packages
INSTALLED_PACKAGES=()
NOT_INSTALLED_PACKAGES=()

# Install official repository packages, skipping already installed ones
echo "Installing official repository packages..."
for PACKAGE in "${REPO_PACKAGES[@]}"; do
    if pacman -Q "$PACKAGE" &> /dev/null; then
        echo "$PACKAGE is already installed. Skipping..."
        INSTALLED_PACKAGES+=("$PACKAGE")
    else
        echo "Installing $PACKAGE..."
        sudo pacman -S --noconfirm "$PACKAGE"
        INSTALLED_PACKAGES+=("$PACKAGE")
    fi
done

# Determine packages that were not installed (if any)
for PACKAGE in "${REPO_PACKAGES[@]}"; do
    if ! pacman -Q "$PACKAGE" &> /dev/null; then
        NOT_INSTALLED_PACKAGES+=("$PACKAGE")
    fi
done

# Display installed and not installed packages
echo
echo "Installed packages:"
for PACKAGE in "${INSTALLED_PACKAGES[@]}"; do
    echo "- $PACKAGE"
done

echo
echo "Not installed packages:"
for PACKAGE in "${NOT_INSTALLED_PACKAGES[@]}"; do
    echo "- $PACKAGE"
done

echo
echo "Script execution completed."
