#!/bin/bash

persistence_dir=/live/persistence/TailsData_unlocked
install_dir=$persistence_dir/electrum

#Apply udev rules, needed for the HW wallet devices to be usable
pkexec bash ${install_dir}/add_udev_rules.sh

# Start Electrum
electrum_AppImage=$(find ${install_dir}/*.AppImage | tail -n 1)
${electrum_AppImage} --forgetconfig
