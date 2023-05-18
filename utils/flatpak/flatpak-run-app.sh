#!/bin/bash

# This script is designed to start a Flatpak application.
# It requires two arguments:
#   1. The Flatpak application ID (app_id)
#   2. An optional URL which may be passed to the application, if supported
# The script performs the following tasks:
#   * Verifies the availability of the Flatpak package. If not available, it terminates.
#   * Searches for and executes the `flatpak-run-before-$app_id.sh` and `flatpak-run-$app_id.sh` scripts, if they exist in the `/live/persistence/TailsData_unlocked/$app_id` directory.
#   * If `flatpak-run-$app_id.sh` doesn't exist, the script attempts to find the application's .desktop file in the Flatpak directory, extracts the 'Exec' command, and executes it.


# Setting directories
persistence_dir="/live/persistence/TailsData_unlocked"
flatpak_share_dir="/home/amnesia/.local/share/flatpak/exports/share"
app_id="$1"
optional_url="$2"

# Logs a message to the terminal or the system log, depending on context.
# The first argument is the type of message ("info"|"warning"|"error"|"question"), the second argument is the actual message to log.
log() {
  if [ -t 1 ]; then
    # If stdout is a terminal, simply echo the message type and the message
    echo "${1^}: $2"
  else
    # If stdout is not a terminal, send a desktop notification
    notify-send -u critical -i "dialog-${1}" "${1^}: $2"
  fi
}

# Ensure application ID has been passed to the script
if [ $# -eq 0 ]; then
  log "error" "No arguments supplied. Please provide a flatpak application ID. Exiting..."
  exit 1
fi

# Run the flatpak-installation-check.sh script and capture the exit code
./flatpak-installation-check.sh
exit_code=$?

# If the exit code is not 0, exit with the same code
if [ $exit_code -ne 0 ]; then
  log "error" "Flatpak installation check failed with exit code: $exit_code. Exiting..."
  exit $exit_code
fi

# Check if the $persistent_app_dir/flatpak-run-before exists and is executable
run_before_script="$persistence_dir/$app_id/flatpak-run-before-$app_id.sh"
if [ -e "$run_before_script" ]; then
  if [ ! -x "$run_before_script" ]; then
    log "error" "The script $run_before_script is not executable. Exiting..."
    exit 1
  fi
  # Run the script with optional_url as argument
  ./"$run_before_script" "$optional_url"
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    log "error" "Execution of $run_before_script failed with exit code: $exit_code. Exiting..."
    exit $exit_code
  fi
fi

# Check if the $persistence_dir/$app_id/flatpak-run.sh exists and is executable
run_script="$persistence_dir/$app_id/flatpak-run.sh"
if [ -e "$run_script" ]; then
  if [ ! -x "$run_script" ]; then
    log "error" "The script $run_script is not executable. Exiting..."
    exit 1
  fi
  # Run the script with optional_url as argument
  ./"$run_script" "$optional_url"
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    log "error" "Execution of $run_script failed with exit code: $exit_code. Exiting..."
    exit $exit_code
  fi
else
  # If $run_script doesn't exist, look for a .desktop file
  desktop_file_path="$flatpak_share_dir/applications/$app_id.desktop"
  if [ -e "$desktop_file_path" ]; then
    # Extract the command from the Exec line and run it
    exec_command=$(grep -oP '^Exec=\K.*' "$desktop_file_path")
    # Replace %u with optional_url
    exec_command=${exec_command/\%u/$optional_url}
    $exec_command
  else
    log "error" "Neither the run script $run_script nor the .desktop file $desktop_file_path exists. Exiting..."
    exit 2
  fi
fi
