#!/bin/bash

# Log actions to a file
log_action() 
{
  echo "$(date "+%Y-%m-%d %H:%M:%S") - $1" >> script_output.log
}

# Prompt the user for a directory path
echo "Please enter the directory path:"
read directory_path

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
  echo "Directory '$directory_path' does not exist."
  exit 1
fi

# Prompt the user for permissions numbers
echo "Please enter the permissions number (e.g., 777):"
read permissions

# Check if the input is a valid three-digit octal number
if [[ ! "$permissions" =~ ^[0-7]{3}$ ]]; then
  echo "Invalid input. Permissions number must be a three-digit octal number."
  exit 1
fi

# Change permissions for all files in the directory and log actions
log_action "Changing permissions to $permissions in directory: $directory_path"

for file in "$directory_path"/*; do
  if [ -f "$file" ]; then
    chmod "$permissions" "$file"
    echo "Changed permissions for file: $file"
    log_action "Changed permissions for file: $file"
    sleep 1  # Add a 1-second delay between file changes
  fi
done

# List directory contents and display new permissions
echo "Directory contents of '$directory_path' with new permissions ($permissions):"
ls -l "$directory_path"

# Exit the script
exit 0