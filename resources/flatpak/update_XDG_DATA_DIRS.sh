#!/bin/bash

# This script adds the path of the Flatpak shared directory to the XDG_DATA_DIRS environment variable in the .profile file.
# This allows GNOME to locate the icons for Flatpak app desktop menu items.
# To ensure the changes persist after Tail reboots, the script stores the .profile file in the persistent 'dotfiles' directory.

# Define the persistence directory
persistence_dir=/live/persistence/TailsData_unlocked

# Define the Flatpak share directory
flatpak_share_dir="$HOME/.local/share/flatpak/exports/share"

# Check if the .profile file exists in the persistence directory
if [ ! -f "$persistence_dir/dotfiles/.profile" ]; then
    # Copy the .profile file if it doesn't exist
    cp ~/.profile $persistence_dir/dotfiles/
fi

# Check if the Flatpak share directory is already in the .profile file
if ! grep -q "$flatpak_share_dir" "$persistence_dir/dotfiles/.profile"; then
    # If not, add it
    echo 'export XDG_DATA_DIRS="'"$flatpak_share_dir"':${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"' >> $persistence_dir/dotfiles/.profile
fi
