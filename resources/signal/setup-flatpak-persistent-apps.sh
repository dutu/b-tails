#!/bin/sh

persistence_dir=/live/persistence/TailsData_unlocked
mkdir -p /home/amnesia/.local/share

if ! file /home/amnesia/.local/share/flatpak | grep -q 'symbolic link'; then
  rm -rf --one-file-system /home/amnesia/.local/share/flatpak
  ln -s $persistence_dir/flatpak /home/amnesia/.local/share/flatpak
fi
