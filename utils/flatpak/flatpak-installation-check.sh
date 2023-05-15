#!/bin/bash

# This script check the status of Flatpak installation.
# If Flatpak is installed exit code is 0, otherwise a dialogue is displayed and exit code is none-zero.

# Function to display Zenity dialog and exit with specified code
display_dialog_and_exit() {
  local dialog_type="$1"
  local message="$2"
  local exit_code="$3"
  zenity --"$dialog_type" --text "$message" --title "Flatpak Installation Check"
  exit "$exit_code"
}

# File containing the list of additional software packages
additional_software_file="/live/persistence/TailsData_unlocked/live-additional-software.conf"

# Check if 'flatpak' command is available
if command -v flatpak >/dev/null 2>&1; then
  exit 0
fi

# Check if flatpak is in the additional software list
if ! grep -q "^flatpak$" "$additional_software_file"; then
  display_dialog_and_exit  "error" "Flatpak is not installed.\nPlease install Flatpak and configure it to install every time after reboot." 2
fi

# Check dpkg.log for flatpak installation completed message
if grep -q "status installed flatpak" /var/log/dpkg.log; then
  display_dialog_and_exit "error" "Flatpak installation is not detected.\nPlease reinstall Flatpak and configure to install every time after reboot." 2
fi

# Check dpkg.log for flatpak installation start message
if grep -q "install flatpak" /var/log/dpkg.log; then
  display_dialog_and_exit "warning" "Flatpak installation is in progress.\nPlease wait a few minutes and try again." 1
fi

# Check journalctl for additional software installation start message
if journalctl | grep -q "Installing your additional software"; then
  display_dialog_and_exit "warning" "Flatpak installation is pending.\nPlease wait a few minutes and try again." 1
fi

display_dialog_and_exit "error" "Flatpak is not installed.\nPlease reinstall Flatpak and configure it to install every time after reboot." 2
