#!/bin/bash

# Function to check port availability
thread_count() {
    ps -eLf|wc -l
}

# Function to list service details
list_service_details() {
    read -p "Enter the service name: " service
    systemctl status $service
}

# Function to check IP address availability
check_ip() {
    read -p "Enter the IP address to check: " ip
    ping -c 1 $ip
}

# Function to manage firewall rules
manage_firewall() {
    read -p "Enter 'open' to open a port or 'allow' to allow an IP address: " action
    if [ "$action" == "open" ]; then
        read -p "Enter the port number to open: " port
        sudo iptables -A INPUT -p tcp --dport $port -j ACCEPT
        echo "Port $port opened."
    elif [ "$action" == "allow" ]; then
        read -p "Enter the IP address to allow: " ip
        sudo iptables -A INPUT -s $ip -j ACCEPT
        echo "IP address $ip allowed."
    else
        echo "Invalid action."
    fi
}

# Main menu
while true; do
    echo "Choose an option:"
    echo "1. Total number of threads"
    echo "2. List service details"
    echo "3. Check IP address availability"
    echo "4. Manage firewall"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) thread_count ;;
        2) list_service_details ;;
        3) check_ip ;;
        4) manage_firewall ;;
        5) exit ;;
        *) echo "Invalid option";;
    esac
done
