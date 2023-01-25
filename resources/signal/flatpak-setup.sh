#!/bin/sh

mkdir -p /home/amnesia/Persistent/flatpak
mkdir -p /home/amnesia/.local/share

if ! file /home/amnesia/.local/share/flatpak | grep -q 'symbolic link'; then
        rm -rf --one-file-system /home/amnesia/.local/share/flatpak
        ln -s /home/amnesia/Persistent/flatpak /home/amnesia/.local/share/flatpak
fi

mkdir -p /home/amnesia/Persistent/app
mkdir -p /home/amnesia/.var
ln -s /home/amnesia/Persistent/app /home/amnesia/.var/app
