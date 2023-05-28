#!/bin/bash

# This script starts the latest version of Electrum
# It first checks if udev rules needed for the HW wallet devices have been applied already.
# If not, it applies the rules by copying them to /etc/udev/rules.d/ and notifying udevadm

# Define the persistence directories
persistence_dir=/live/persistence/TailsData_unlocked
install_dir=$persistence_dir/electrum

# Function to apply udev rules needed for the HW wallet devices to be usable
function apply_udev_rules {
  # Copy the rules file to /etc/udev/rules.d/
  rsync -a $install_dir/udev/*.rules /etc/udev/rules.d/
  # Reload rules and trigger udev
  udevadm control --reload-rules
  udevadm trigger
}

# Check if udev rules needed for the HW wallet devices have been applied already
rules_file="/etc/udev/rules.d/51-coinkite.rules"
if [ ! -e "$rules_file" ]; then
  # If not, run 'apply_udev_rules' function with superuser privileges
  pkexec bash -c "install_dir=$install_dir; $(declare -f apply_udev_rules); apply_udev_rules"
fi

# Check if user's 'wallets' directory exists
if [ ! -e "/home/amnesia/.electrum/wallets" ]; then
  # If not, we need to set it up by running 'electrum-config-setup.sh' that we normally run at reboot
  # (This case may occur if "Electrum Bitcoin Wallet" feature of Persistent Storage has just been disabled and system not yet rebooted, in which case `wallets` directory and `config.default` are not set)
  $persistence_dir/dotfiles/.config/autostart/amnesia.d/electrum-config-setup.sh
fi

# Get the electrum AppImage file path
electrum_AppImage=$(find ${install_dir}/*.AppImage | tail -n 1)
# start electrum using '~/.electrum' directory and all other parameters passed to this script
${electrum_AppImage} --dir /home/amnesia/.electrum "$@"
