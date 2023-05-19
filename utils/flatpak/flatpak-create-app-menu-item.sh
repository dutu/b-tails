#!/bin/bash

# This script generates a menu item, represented by a .desktop file, for a specific Flatpak application, the Id of which is passed as a parameter.
# If a custom .desktop file is available in the application's persistent directory, it is used as the source for the menu item.
# If this custom file does not exist, the script defaults to using the .desktop file from the Flatpak application's own directory.
# A copy of the source .desktop file is placed in the persistent dotfile directory, and a corresponding symbolic link is created in the local directory.

# Define the persistence directory
persistence_dir=/live/persistence/TailsData_unlocked

# Define the Flatpak applications directory and the .desktop directory for menu items
flatpak_share_dir="/home/amnesia/.local/share/flatpak/exports/share/applications/"
local_dir="/home/amnesia/.local/share/applications/"
persistent_local_dir="$persistence_dir/dotfiles/local/share/applications"

# Logs a message to the terminal or the system log, depending on context
log() {
  if [ -t 1 ]; then
    # If File descriptor 1 (stdout) is open and refers to a terminal
    echo "$1"
  else
    # If stdout is not a terminal (maybe it's a pipe, a file, or /dev/null)
    logger "$1"
  fi
}

create_app_menu_item() {
  app_id=$1
  # Determine the source of the .desktop file for the app
  if [[ -f "$persistence_dir/$app_id/$app_id.desktop" ]]; then
    # If a custom desktop file exists in the persistence directory use this as source
    desktop_file_path="$persistence_dir/$app_id/$app_id.desktop"
  else
    # If no custom desktop file, use the one from flatpak application directory as source
    desktop_file_path="$flatpak_share_dir/applications/$app_id.desktop"
  fi

  # Check if the source .desktop file has been located
  if [[ -f $desktop_file_path ]]; then
    # Create a copy of it in the persistent local .desktop directory
    log "Create menu item for $app_id..."
    cp "$desktop_file_path" "$persistent_local_dir/$app_id.desktop"

    # Check if a symbolic link or file already exists in local .desktop directory
    if [[ -e "$local_dir/$app_id.desktop" ]]; then
      # If it does, delete it
      log "Menu item for $app_id already exists. Deleting..."
      rm "$local_dir/$app_id.desktop"
    fi

    # Create a symbolic link to it in the local .desktop directory
    ln -s "$persistent_local_dir/$app_id.desktop" "$local_dir/$app_id.desktop"
    exit 0
  else
    log "Could not locate the source .desktop file for application ID '$app_id'. Exiting..."
    exit 2
  fi
}

# Ensure application ID has been passed to the script
if [ $# -eq 0 ]; then
  log "No arguments supplied. Please provide a flatpak application ID."
  exit 1
fi

# Ensure we are running as 'amnesia'
if test "$(whoami)" != "amnesia"; then
  log "You must run this program as 'amnesia' user."
  exit 1
fi

# Call the function with the first command line argument
create_app_menu_item "$1"
