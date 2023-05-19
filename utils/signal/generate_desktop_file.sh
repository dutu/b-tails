#!/bin/bash

# This script generates .desktop file, that enables GNOME to display the menu item.
# Exec entry is replaced to execute a custom script `start_$app_id.sh` that launches the application.
# Icon entry is replaced to point to application's icon file in flatpak share directory.
#

# Define the persistence directory
persistence_dir=/live/persistence/TailsData_unlocked

# Define the the local and persistent .desktop directory for menu items
local_share_dir="$HOME/.local/share/applications/"
persistsnt_share_dir=


# Define the Flatpak share directory
flatpak_share_dir="$HOME/.local/share/flatpak/exports/share"


# Define the Signal app id
app_id="org.signal.Signal"


echo "Checking if running as root..."
if test "$(whoami)" != "root"
then
    echo "You must run this program as root."
    exit 1
fi

# Create target directory if it doesn't exist
echo "Creating persistent $app_id directory..."
mkdir -p $persistence_dir/$app_id
chown -R amnesia:amnesia $persistence_dir/$app_id
chmod 700 $persistence_dir/$app_id

# Copy the desktop file
echo "Copying '$app_id.desktop' from flatpak application directory..."
rsync -a "$flatpak_share_dir/applications/$app_id.desktop" "$persistence_dir/$app_id/"

# Replace the Exec entry in the target file
echo "Replacing Exec entry in $app_id.desktop..."
sed -i "s|Exec=.*|Exec=$persistence_dir/$app_id/start_$app_id.sh \"%U\"|g" "$persistence_dir/$app_id/$app_id.desktop"

# Replace the Exec entry in the target file
echo "Replacing Icon entry in $app_id.desktop..."
sed -i "s|Icon=.*|Icon=$flatpak_share_dir|g" "$persistence_dir/$app_id/$app_id.desktop"
