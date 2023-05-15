#!/bin/bash

# This script generates a persistent .desktop file,
# that enables GNOME to display the menu item with a custom start-up script for the application.
# The custom script 'start_signal.sh' is used to set the proxy before launching the application.

# Define the persistence directory
persistence_dir=/live/persistence/TailsData_unlocked

# Define the Flatpak share directory
flatpak_share_dir="$HOME/.local/share/flatpak/exports/share"

# Define the Signal app id
app_id="org.signal.Signal"


# Create target directory if it doesn't exist
sudo mkdir -p $persistence_dir/$app_id
sudo chown -R amnesia:amnesia $persistence_dir/$app_id
chmod 700 $persistence_dir/$app_id

# Copy (or overwrite) the file using rsync
rsync -av "$flatpak_share_dir/applications/$app_id.desktop" "$persistence_dir/$app_id/"

# Replace the Exec entry in the target file
sed -i "s|Exec=.*|Exec=$persistence_dir/$app_id/start_$app_id.sh \"%U\"|g" "$persistence_dir/$app_id/$app_id.desktop"

