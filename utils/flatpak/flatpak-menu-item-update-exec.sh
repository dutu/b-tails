#!/bin/bash

# Script description:
# This script updates the Exec command in a Flatpak application's .desktop file, given the application's ID as parameter.
# The process is as follows:
# 1. Checks if any Exec commands start with "flatpak" or "/usr/bin/flatpak", exits if not.
# 2. Checks the existence of the .desktop file in the persistent desktop directory, exits if not found.
# 3. If 'flatpak-run.sh' in the app's persistent directory exists, uses it. If not, creates it from a generic script.
# 4. Replaces the Exec command in [Desktop Entry] section with a new one to execute the 'flatpak-run.sh' script
# 5. Replaces the Exec command in remaining section with a new one to execute flatpak wrapped within "/bin/bash -c"

# Error codes
ERR_RUN_SCRIPT_NOT_EXECUTABLE=1
ERR_GENERIC_RUN_SCRIPT_MISSING=2
ERR_NO_FLATPAK_COMMAND=3
ERR_NO_DESKTOP_FILE=4

# Define necessary directories and paths for script and persistent files
persistence_dir="/live/persistence/TailsData_unlocked"
persistent_desktop_dir="$persistence_dir/dotfiles/.local/share/applications"
run_script_generic="$persistence_dir/flatpak/flatpak-run-generic.sh"
app_id="$1"
persistent_desktop_path="$persistent_desktop_dir/$app_id.desktop"
run_script="$persistence_dir/$app_id/flatpak-run.sh"

# Define the pattern to replace: "flatpak" or "/usr/bin/flatpak"
pattern="^Exec=flatpak|^Exec=/usr/bin/flatpak"

# Function to check and create the flatpak run script if it does not exist
check_and_create_run_script() {
  # Check if $run_script exists
  if [ -f "$run_script" ]; then
    # Check if $run_script is executable
    if [ ! -x "$run_script" ]; then
      echo "Error: flatpak-run.sh exists but is not executable at the following path: $run_script. Exiting..."
      exit $ERR_RUN_SCRIPT_NOT_EXECUTABLE
    else
      echo "flatpak-run.sh exists and will be used to launch the $app_id."
      return
    fi
  else
    # Check if $run_script_generic exists
    if [[ ! -f "$run_script_generic" ]]; then
      echo "Error: Generic run script does not exist at the following path: $run_script_generic. Please reinstall flatpak utils. Exiting..."
      exit $ERR_GENERIC_RUN_SCRIPT_MISSING
    fi

    # Create the run_script based on run_script_generic.
    cp "$run_script_generic" "$run_script"
    chmod +x "$run_script"
  fi
}

# Function to update flatpak Exec command in "[Desktop Entry]" section
update_flatpak_exec_in_desktop_entry_section() {
  # Store the new Exec command
  new_exec_command="Exec=$persistence_dir/flatpak/flatpak-exec.sh"

  # Use awk to only replace the Exec command under [Desktop Entry]
  awk -v pattern="$pattern" -v replacement="$new_exec_command" '
    /^\[Desktop Entry\]/ {in_section = 1}
    /^\[/ {if ($0 != "[Desktop Entry]") in_section = 0}
    in_section && $0 ~ pattern {$0 = replacement}
    {print}
  ' "$persistent_desktop_path" > temp_file

  # Check if the file has been modified
  if ! cmp -s "$persistent_desktop_path" temp_file; then
    echo "Replaced 'Exec=flatpak' and 'Exec=/usr/bin/flatpak' with '$new_exec_command' in '[Desktop Entry]' section"
    mv temp_file "$persistent_desktop_path"
  else
    rm temp_file
  fi
}

# Function to update remaining flatpak Exec commands in other sections
update_flatpak_exec_in_other_sections() {

  if ! grep -qE "$pattern" "$persistent_desktop_path"; then
    return
  fi

  # Make a backup of the original file before changes
  cp "$persistent_desktop_path" "${persistent_desktop_path}.bak"

  # Substitute the original 'flatpak' or '/usr/bin/flatpak' with wrap them within "/bin/bash -c".
  sed -E -i 's|^Exec=((flatpak|/usr/bin/flatpak)(.*))|Exec=/bin/bash -c "command -v flatpak >/dev/null \&\& flatpak\3"|' "$persistent_desktop_path"

  # Escapes potential placeholder (%f, %u, %d, etc.), so that they are not prematurely interpreted when passed to /bin/bash -c
  # These placeholders can be found in .desktop files, and they get replaced with specific values when the Exec command gets executed.
  sed -E -i 's|%(.)|\\%\\1|g' "$persistent_desktop_path"

  echo "Replaced 'Exec=flatpak' and 'Exec=/usr/bin/flatpak' commands with '/bin/bash -c \"command -v flatpak >/dev/null \&\& flatpak\"'"
}

# Check for command-line arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied. Please provide a flatpak application ID."
  exit $ERR_NO_ARGS
fi

# Check the running user
if test "$(whoami)" != "amnesia"; then
  echo "You must run this program as 'amnesia' user."
  exit $ERR_NOT_AMNESIA
fi

if [[ ! -f $persistent_desktop_path ]]; then
  echo "Error: .desktop file does not exist at the following path: $persistent_desktop_path. Exiting..."
  exit $ERR_NO_DESKTOP_FILE
fi

if ! grep -qE "$pattern" "$persistent_desktop_path"; then
  echo "Error: No Exec entry starting with 'flatpak' or '/usr/bin/flatpak' found. Nothing to update. Exiting..."
  exit $ERR_NO_FLATPAK_COMMAND
fi

# Call the function to check and create the flatpak run script if it does not exist
check_and_create_run_script
# Call the function to update Exec command
update_flatpak_exec_in_desktop_entry_section
update_flatpak_exec_in_other_sections
