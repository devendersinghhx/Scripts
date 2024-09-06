#!/bin/bash

# Define an array of AUR packages to install
AUR_PACKAGES=(
   "visual-studio-code-bin"
   "pamac-aur"
   "envycontrol"
   "onlyoffice-bin"
)

# Arrays to track installed and not installed packages
INSTALLED_AUR_PACKAGES=()
NOT_INSTALLED_AUR_PACKAGES=()

# Install AUR packages using yay
echo "Installing AUR packages..."
for PACKAGE in "${AUR_PACKAGES[@]}"; do
    if yay -Q "$PACKAGE" &> /dev/null; then
        echo "$PACKAGE is already installed. Skipping..."
        INSTALLED_AUR_PACKAGES+=("$PACKAGE")
    else
        echo "Installing $PACKAGE from AUR..."
        yay -S --noconfirm "$PACKAGE"
        # Check again after installation to confirm
        if yay -Q "$PACKAGE" &> /dev/null; then
            INSTALLED_AUR_PACKAGES+=("$PACKAGE")
        else
            NOT_INSTALLED_AUR_PACKAGES+=("$PACKAGE")
        fi
    fi
done

# Display installed and not installed packages
echo
echo "Installed AUR packages:"
for PACKAGE in "${INSTALLED_AUR_PACKAGES[@]}"; do
    echo "- $PACKAGE"
done

echo
echo "Not installed AUR packages:"
for PACKAGE in "${NOT_INSTALLED_AUR_PACKAGES[@]}"; do
    echo "- $PACKAGE"
done

echo
echo "Script execution completed."

