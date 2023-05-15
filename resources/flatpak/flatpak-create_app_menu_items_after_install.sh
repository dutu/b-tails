#!/bin/bash

# This script automatically creates menu items for all installed Flatpak applications.
# If the Flatpak package is already installed, menu creation is immediate.
# Otherwise, the script starts monitoring for the Flatpak installation, triggering menu creation upon its completion.

# Define the timeout value
timeout_duration='5m'

# Define the persistence directory
persistence_dir=/live/persistence/TailsData_unlocked

# Define the Flatpak applications directory and the local .desktop directory for menu items.
flatpak_share_dir="$HOME/.local/share/flatpak/exports/share/applications/"
local_dir="$HOME/.local/share/applications/"

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

# Create app menu items after flatpak installation
create_app_menu_items() {
  # If flatpak is installed Get a list of all installed flatpak applications
  flatpak_list=$(flatpak list --columns=application)
  # Iterate over each item in the flatpak list
  for app in $flatpak_list; do
    # Check if the app name is not empty
    if [[ -n "$app" ]]; then
      # Extract the app id from the app string
      app_id=$(echo $app | awk -F'/' '{print $NF}')
      # Construct the path to the .desktop file for the app
      if [[ -f "$persistence_dir/$app_id/$app_id.desktop" ]]; then
          # If a custom desktop file exists in the persistence directory use this
          desktop_file_path="$persistence_dir/$app_id/$app_id.desktop"
      else
          # If no custom desktop file, use the one from flatpak application directory
          desktop_file_path="$flatpak_share_dir/applications/$app_id.desktop"
      fi
      # Check if the .desktop file exists
      if [[ -f $desktop_file_path ]]; then
          # If the .desktop file exists, check if a symbolic link or file already exists in the local directory
          if [[ ! -e "$local_dir/$app_id.desktop" ]]; then
              # If no symbolic link or file exists, create a symbolic link to it in the local .desktop directory
              log "Create menu item for $app_id..."
              ln -s "$desktop_file_path" "$local_dir/$app_id.desktop"
          else
              log "Menu item for $app_id already exists. Skipping..."
          fi
      fi
    fi
  done
}

# Check if flatpak is already installed
if command -v flatpak >/dev/null 2>&1; then
    log 'Flatpak package is installed. Creating app menu items...'
    create_app_menu_items
    exit 0
fi

# Start monitoring dpkg.log to determine completion of flakpak installation
# The `timeout` command allows the script to exit if the specified duration is reached.
# The `tail -F` command outputs the end of the dpkg.log file and watches it for new content.
timeout "$timeout_duration" tail -F /var/log/dpkg.log | while read -r line; do
    if echo "$line" | grep -q 'status installed flatpak'; then
        log "$line"
        # Kills the `tail` process that is a child of the current script process ($$).
        # This effectively stops the monitoring of dpkg.log when flatpak is detected as installed.
        pkill -P $$ tail
    fi
done

if [ $? -eq 124 ]; then
    # Timeout occurred
    log 'Timeout occurred while waiting for "status installed flatpak"'
fi

# Check if flatpak has been installed
if ! command -v flatpak >/dev/null 2>&1; then
    log 'Flatpak installation did not complete'
    exit 1
fi

log 'Flatpak installation completed. Creating app menu items...'
create_app_menu_items
