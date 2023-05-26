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

config_file=/home/amnesia/.electrum/config
wallets_dir=/home/amnesia/.electrum/wallets

mkdir -p $install_dir/wallets
# Check if wallets directory exists
if [ ! -d "$wallets_dir" ]; then
  # If not, link the 'wallets_dir'
  ln -s $install_dir/wallets $wallets_dir
fi

mkdir -p /home/amnesia/.electrum
# Check if config file exists
if [ ! -e "$config_file" ]; then
  # If not, copy the 'config.default'
  cp $install_dir/config.default $config_file
fi
