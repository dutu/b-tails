#!/bin/bash

#Apply udev rules, needed for the HW wallet devices to be usable

persistence_dir=/live/persistence/TailsData_unlocked
install_dir=$persistence_dir/electrum

# Apply udev rules by copying them to /etc/udev/rules.d/ and notifying udevadm
rsync -a $install_dir/udev/*.rules /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger
