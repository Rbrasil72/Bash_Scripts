#!/bin/bash

#     _________
#    / ======= \
#   / __________\
#  | ___________ |
#  | | -       | |
#  | |         | |
#  | |_________| |________________________
#  \=____________/   Rodrigo Brasil       )
#  / """"""""""" \                       /
# / ::::::::::::: \                  =D-'
#(_________________)

#Date created: 13/10/2023
#Last Revision: 13/10/2023
#Purpose: Makes a backup of the syslog and wtmp logfiles in zip format into a directory called backup and cleans the originals

<<'COMMENT' 
syslog - often found at /var/log/syslog depending on the distro, is the system log file that records system-related events and messages.
It includes a wide range of system messages, such as kernel messages, system startup and shutdown messages, 
device driver information, hardware and software errors, system daemons status, and various service activities.
It is an essential tool for system administrators and developers for troubleshooting and monitoring system health.
COMMENT

<<'COMMENT'
wtmp - often found at /var/log/wtmp depending on the distro, It maintains a historical record of user login sessions, including the time, date, 
terminal or source from which users logged in and logged out. It also records system reboots and shutdowns.
COMMENT

# Define a list of characters for the loading animation
loading_message="\e[1mCompressing|\e[32m                        \e[0m|(0%)\r"

# Number of iterations
iterations=25

#Clears the terminal
clear

#ASCII ART and loadings
    echo " "
    echo "                               ###   #######"
    echo " ####  #####   ####           #   #  #"      
    echo "#    # #    # #              #     # #"       
    echo "#    # #    #  ####          #     # ######"  
    echo "#    # #####       #         #     #       #"
    echo "#    # #      #    #          #   #  #     #" 
    echo " ####  #       ####            ###    #####"  
    echo "                     #######"                 

    echo -ne "\n"

    echo "================================================="

    echo -ne "\n"

    echo -e "\e[1m \rsyslog & wtmp found!\r"
    sleep 1

    echo -ne "\n"

    # Perform the loading animation
    for ((i = 0; i < $iterations; i++)); do
        # Calculate the progress percentage
        progress=$((i * 105 / iterations))

        # Create the loading bar
        loading_bar="$(printf '%*s' "$((i * 50 / iterations))" | tr ' ' '#')"
        
        # Print the loading animation
        echo -ne "\e[1mCompressing|\e[32m$loading_bar\e[0m|($progress%)\r"

        # Sleep to control the speed
        sleep 0.1
    done

    echo -ne '\n'
    sleep 1

    echo -ne '\n\n'

    # Define the backup directory and timestamp format
    backup_dir="/var/log/backups"
    timestamp=$(date '+%Y-%m-%d-%H:%M:%S')

    # Create the backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    # List of log logs to compress
    log_logs=("/var/log/syslog" "/var/log/wtmp")

    # Loop
    for file in "${log_logs[@]}"; do

        # Get the file size before compression
        file_size=$(du -sh "$file" | cut -f1)
        echo -ne "File size of \e[32m$file\e[0m before compression: \e[33m$file_size\e[0m"
        echo -ne "\n"

        # Compress the log file
        backup_file="$backup_dir/$(basename $file)-$timestamp.zip"
        tar -czf "$backup_file" "$file" 2>/dev/null

        # Get the file size after compression
        compressed_size=$(du -h "$backup_file" | cut -f1)

        # Print the file size before compression
        echo -ne "Backup created: \e[34m$backup_file\e[0m"
        echo -ne "\n"
        echo -ne "File size of compressed backup: \e[33m$compressed_size\e[0m"
        echo -ne '\n\n'

        #Clear the contents of the log file
        > "$file"

        # Compare sizes
        if [[ "$file_size" != "$compressed_size" ]]; then
            echo -ne "\e[93;1mCompression successful & log file cleared!\e[0m"
            echo -ne '\n\n'
        else
            echo -ne "\e[31;1mCompression failed or no data in the log file.\e[0m"
            echo -ne '\n\n'
        fi
    done