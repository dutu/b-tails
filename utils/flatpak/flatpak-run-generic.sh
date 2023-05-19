#!/bin/bash

# This script is designed to start a specific Flatpak application.
# The script performs the following tasks:
#   * Verifies the availability of the Flatpak package. If not available, the script exits.
#   * Launches the Flatpak application.
# The script contains a placeholder where users can insert additional commands to be executed before launching the Flatpak application. This could be setting a proxy server, for example.
# The script accepts an optional parameter. This parameter, if provided, is assumed to be a URL that is passed from a .desktop file, which happens in cases such as drag and drop operations where the file's URL can be directly passed to the Flatpak application.

exec_command='log "error" "This is a generic script which needs to be customised to launch the flatpak application"'

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

# Run the flatpak-installation-check.sh script and capture the exit code
./flatpak-installation-check.sh
exit_code=$?

# If the exit code is not 0, exit with the same code
if [ $exit_code -ne 0 ]; then
  log "error" "Flatpak installation check failed with exit code: $exit_code. Exiting..."
  exit $exit_code
fi

### START: Insert pre-launch commands or configurations here.
### For instance, to set up a proxy server or perform any pre-launch configurations.

### END: Pre-launch customization.

# Executes exec command
eval "$exec_command"
