#!/bin/bash

# Script description:
# This script updates the Exec command in a Flatpak application's .desktop file, given the application's ID as parameter.
# The process is as follows:
# 1. Checks the existence of the .desktop file in the persistent desktop directory, exits if not found.
# 2. Verifies that the current Exec entry starts with "flatpak run", exits if not.
# 3. If 'flatpak-run.sh' in the app's persistent directory exists, uses it. If not, creates it from a generic script.
# 4. Replaces the original Exec command with a new one to execute the 'flatpak-run.sh' script.


# Define necessary directories and paths for script and persistent files
persistence_dir="/live/persistence/TailsData_unlocked"
persistent_desktop_dir="$persistence_dir/dotfiles/.local/share/applications"
run_script_generic="$persistence_dir/flatpak/flatpak-run-generic.sh"
app_id="$1"
run_script="$persistence_dir/$app_id/flatpak-run.sh"

# Function to create the flatpak run script if it does not exist
create_run_script() {
  # Check if $run_script exists
  if [ -f "$run_script" ]; then
    # Check if $run_script is executable
    if [ ! -x "$run_script" ]; then
      echo "flatpak-run.sh exists but is not executable. Exiting..."
      exit 1
    else
      echo "flatpak-run.sh exists and will be used to launch the $app_id."
      return
    fi
  else
    # Check if $run_script_generic exists
    if [[ ! -f "$run_script_generic" ]]; then
      echo "Generic run script does not exist. Please reinstall flatpak utils. Exiting..."
      exit 2
    fi
    
    # Create the run_script based on run_script_generic. 
    cp "$run_script_generic" "$run_script"

    # Replace %u with $1 in desktop_exec (%u in desktop_exec represents a placeholder for a URL that could be passed as a parameter to the flatpak application).
    # In the context of executing new run_script, this URL (if passed) will come as the first argument ($1).
    placeholder='$1'
    desktop_exec=${desktop_exec//%u/$placeholder}

    # We insert the desktop_exec into run_script, to be executed when script is called from the desktop file.
    sed -i "s|^\(exec_command=\).*|\1\"$desktop_exec\"|" "$run_script"

    chmod +x "$run_script"
  fi
}


# Function to update flatpak app's Exec command
update_flatpak_app_exec() {
  persistent_desktop_path="$persistent_desktop_dir/$app_id.desktop"

  if [[ ! -f $persistent_desktop_path ]]; then
    echo "Error: $persistent_desktop_path does not exist. Exiting..."
    exit 2
  fi

  desktop_exec=$(grep -Po '^Exec=\K.*' "$persistent_desktop_path")

  if [[ "$desktop_exec" != "flatpak run"* ]]; then
    echo "Error: Exec entry does not start with 'flatpak run'. Exiting..."
    exit 1
  else
    create_run_script
  fi

  sed -i "s|^Exec=.*|Exec=$run_script $app_id \%u|" "$persistent_desktop_path"
  echo "Updated Exec command to run '$run_script $app_id'."
}

# Check for command-line arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied. Please provide a flatpak application ID."
  exit 1
fi

# Check the running user
if test "$(whoami)" != "amnesia"; then
  echo "You must run this program as 'amnesia' user."
  exit 1
fi

# Call the function to update Exec command
update_flatpak_app_exec
