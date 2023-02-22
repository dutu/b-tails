#!/bin/bash

persistence_dir=/live/persistence/TailsData_unlocked
pkexec bash ${persistence_dir}/electrum/add_udev_rules.sh
electrum_AppImage=$(find ${persistence_dir}/electrum/*.AppImage | tail -n 1)

${electrum_AppImage} --forgetconfig
