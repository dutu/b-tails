#!/bin/bash

# This script updates the icon for a Flatpak application, given the app's Id as an argument.
# It first checks if the .desktop file for the application exists in the local directory.
# If it does, it examines the Icon entry in the file.
# If the Icon entry matches the app's Id, the script looks for a new icon in two places:
#   - the app's persistent directory
#   - the Flatpak shared directory
# If a new icon is found, the Icon entry in the .desktop file is replaced with the new icon's path.

# Define the persistence directory
persistence_dir="/live/persistence/TailsData_unlocked"
persistent_desktop_dir="$persistence_dir/dotfiles/.local/share/applications"

# Define the Flatpak applications directory and local desktop directory
flatpak_share_dir="/home/amnesia/.local/share/flatpak/exports/share"
local_desktop_dir="/home/amnesia/.local/share/applications"
app_id="$1"

# Function to update the Flatpak app's icon
update_flatpak_app_icon() {
  local_desktop_path="$persistent_desktop_dir/$app_id.desktop"
  # Check if the .desktop file exists
  if [[ ! -f $local_desktop_path ]]; then
    echo "Error: $local_desktop_path does not exist for app id $app_id."
    exit 2
  fi

  # Extract the old icon path from the .desktop file
  old_icon=$(grep -Po '^Icon=\K.*' "$local_desktop_path")

  # Check if the old icon path matches the app id
  if [[ "$old_icon" != "$app_id" ]]; then
    echo "Error: Icon entry does not match the app id $app_id."
    exit 1
  fi

  # Check if the icon file exists in the persistence directory
  for ext in .png .svg .xpm .ico; do
    if [[ -f "$persistence_dir/$app_id/$app_id$ext" ]]; then
      new_icon="$persistence_dir/$app_id/$app_id$ext"
      break
    fi
  done

  # If new_icon is not set, check the flatpak applications directory
  if [[ -z $new_icon ]]; then
    # Icon sizes to search for, in descending order of preference
    for size in 128x128 64x64 48x48 32x32 16x16; do
      for ext in .png .svg .xpm .ico; do
        if [[ -f "$flatpak_share_dir/hicolor/$size/apps/$app_id$ext" ]]; then
          new_icon="$flatpak_share_dir/hicolor/$size/apps/$app_id$ext"
          break 2  # Break out of both loops
        fi
      done
    done
  fi

  # If the new icon is found
  if [[ -n $new_icon ]]; then
    # Replace the old icon path with the new one in the .desktop file
    sed -i "s|^Icon=.*|Icon=$new_icon|" "$local_desktop_path"
    # Force GNOME to recognize a change in the .desktop file to refresh the menu item
    mv "$local_desktop_path" "$local_desktop_dir/$app_id.temp.desktop"
    mv "$local_desktop_dir/$app_id.temp.desktop" "$local_desktop_path"
    echo "New Icon=$new_icon for app id $app_id."
  else
    echo "Error: New icon not found for app id $app_id."
  fi
}

# Ensure application ID has been passed to the script
if [ $# -eq 0 ]; then
  echo "No arguments supplied. Please provide a flatpak application ID."
  exit 1
fi

# Ensure we are running as 'amnesia'
if test "$(whoami)" != "amnesia"; then
  echo "You must run this program as 'amnesia' user."
  exit 1
fi

# Call the function with the first command line argument
update_flatpak_app_icon
