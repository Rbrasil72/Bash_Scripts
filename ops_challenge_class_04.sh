#!/bin/bash

#clears the terminal
clear

#Menu
display_menu()
{
    echo " "
    echo "============================="
    echo "  __  __ ______ _   _ _    _ "
    echo " |  \/  |  ____| \ | | |  | |"
    echo " | \  / | |__  |  \| | |  | |"
    echo " | |\/| |  __| | . \` | |  | |"
    echo " | |  | | |____| |\  | |__| |"
    echo " |_|  |_|______|_| \_|\____/ "
    echo "                             "
    echo "============================="
    echo "1. Hello world"
    echo "2. Ping Myself"
    echo "3. IP Info"
    echo "4. Exit"
    echo "====================="
    echo "Enter your choice (1-4):"
}

#Function to print hello world
hello_world()
{
    clear
    echo "====================="
    echo "    Hello World!"
    echo "====================="
    echo "Hello World!"
    echo "====================="
    read -n 1 -s -r -p "Press any key to continue..."
    
}

#Function to ping itself only 4 times
ping_myself ()
{
    clear
    echo "====================="
    echo "    Ping Myself"
    echo "====================="
    ping -c 4 127.0.0.1
    echo "====================="
    read -n 1 -s -r -p "Press any key to continue..."
}

#Function to print the ip info
ip_self()
{
    clear
    echo "====================="
    echo "    Ip Info!"
    echo "====================="
    ifconfig
    echo "====================="
    read -n 1 -s -r -p "Press any key to continue..."
}

#Main loop
while true; do

    display_menu
    read choise

    case "$choise" in
        1)
            hello_world
            ;;
        2)
            ping_myself
            ;;
        3)
            ip_self
            ;;
        4)
            echo "====================="
            echo "    Goodbye :[ "
            echo "====================="
            exit 0
            ;;
        *)
            echo "Invalid choise please select an option from the menu (1-4)"
            ;;
    esac
done


