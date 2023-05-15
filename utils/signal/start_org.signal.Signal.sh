#!/bin/bash

# This script sets up HTTP and HTTPS proxy settings and launches the Flatpak Signal application.
# The script is constructed to guarantee that any arguments passed through the desktop file are received by the application,
# which is accomplished by extracting the relevant parameters from the EXEC command within the desktop file.
# Passing the parameters is needed for user interactions like opening files by drag-and-drop or activating links associated with the application.

# Define the Flatpak share directory
flatpak_share_dir="$HOME/.local/share/flatpak/exports/share"

# Define the Signal app id
app_id="org.signal.Signal"

# Defines proxy
export HTTP_PROXY=socks://127.0.0.1:9050
export HTTPS_PROXY=socks://127.0.0.1:9050

# Retrieve Exec command from flatpak application desktop file
app_desktop_file="$flatpak_share_dir/applications/$app_id.desktop"
if [ -f "$app_desktop_file" ]; then
    exec_cmd=$(grep '^Exec=' "$app_desktop_file" | cut -d'=' -f2-)
else
    zenity --error --text="No desktop file found for the application."
    exit 1
fi

# Extract the flatpak command and parameters
flatpak_command=$(echo "$exec_cmd" | cut -d' ' -f1)
flatpak_parameters=$(echo "$exec_cmd" | cut -d' ' -f2-)

# Add script arguments to the flatpak parameters
if [ "$#" -gt 0 ]; then
    flatpak_parameters="$flatpak_parameters $*"
fi

# Execute the command
if [ -n "$flatpak_command" ] && [ -n "$flatpak_parameters" ]; then
    "$flatpak_command" $flatpak_parameters
else
    zenity --error --text="No Exec command found in the desktop file, or it's not properly formatted."
    exit 1
fi
