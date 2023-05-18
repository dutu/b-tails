#!/bin/bash

# This script updates the Exec command for a Flatpak application, given the app's Id as an argument.
# It first checks if the .desktop file for the application exists in the local directory.
# If it does, it examines the Exec entry in the file.
# If the Exec entry starts with "flatpak run", the script replaces it with a command to execute a script in the app's persistent directory.
# If this script does not exist, it is created with the original Exec command from the .desktop file.

# Define the persistence directory
persistence_dir="/live/persistence/TailsData_unlocked"
persistent_desktop_dir="$persistence_dir/dotfiles/local/share/applications"

# Define the script that will be used to start the flatpak application
flatpak_run_script="$persistence_dir/flatpak/flatpak-run.sh"

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

# Function to update the Flatpak app's Exec command
update_flatpak_app_exec() {
  app_id=$1

  local_desktop_path="$persistent_desktop_dir/$app_id.desktop"
  # Check if the .desktop file exists
  if [[ ! -f $local_desktop_path ]]; then
    log "Error: $local_desktop_path does not exist for app id $app_id."
    exit 2
  fi

  # Extract the old Exec command from the .desktop file
  old_exec=$(grep -Po '^Exec=\K.*' "$local_desktop_path")

  # Check if the old Exec command starts with "flatpak run"
  if [[ "$old_exec" != "flatpak run"* ]]; then
    log "Error: Exec entry does not start with 'flatpak run' for app id $app_id."
    exit 1
  fi

  # Replace the old Exec command with the new one in the .desktop file
  sed -i "s|^Exec=.*|Exec=$flatpak_run_script $app_id \%u|" "$local_desktop_path"
  log "Updated Exec command to $flatpak_run_script for app id $app_id."
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

# Ensure the script that will be used to start the flatpak application exists
if [[ ! -f "$flatpak_run_script" ]]; then
  log "The script file $flatpak_run_script does not exist. Exiting..."
  exit 2
fi

# Ensure the script is executable
if [ ! -x "$flatpak_run_script" ]; then
  log "The script $flatpak_run_script is not executable. Exiting..."
  exit 1
fi

# Call the function with the first command line argument
update_flatpak_app_exec "$1"
