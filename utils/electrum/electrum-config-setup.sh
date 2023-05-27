#!/bin/bash

# This script links Electrum's default `wallets` directory to persistent storage, if not linked
# and copies `config.default` to Electrum working directory, if there is no `config`.

# The scope is to link the default `wallets` directory to persistent storage, independent of the “Electrum Bitcoin Wallet” feature’s status in Persistent Storage.
# If this feature is ON, Electrum should use the `config` file, preserving configuration changes between reboots.
# If it’s OFF, the `config.default` file should be used and configuration changes are reset post-reboot.

# When the “Electrum Bitcoin Wallet” feature in Persistent Storage is ON, `/live/persistence/TailsData_unlocked/electrum` is already linked to `~/.electrum` and no action is needed.
# When not linked, the feature is OFF, and we need to manually link the `wallets` directory and copy the `config.default` file

# Define the persistence directories
persistence_dir=/live/persistence/TailsData_unlocked
install_dir=$persistence_dir/electrum

# Define the path of the user's Electrum config file and wallets directory
config_file=/home/amnesia/.electrum/config
wallets_dir=/home/amnesia/.electrum/wallets

# Define the path of the skeleton config file (the skeleton file provides default settings that are copied to new user directories)
skel_config=/etc/skel/.electrum/config

mkdir -p $install_dir/wallets
# Check if user's wallets directory does not exists
if [ ! -d "$wallets_dir" ]; then
  #
  # Link the 'wallets_dir'
  ln -s $install_dir/wallets $wallets_dir
fi

mkdir -p /home/amnesia/.electrum

# Check if the user's Electrum config is identical to the skeleton config file
if cmp -s "$config_file" "$skel_config"; then
  # Copy the 'config.default' to the user's config file, overwriting the the skeleton config file
  cp $install_dir/config.default $config_file
fi