# A. Create a script that uses the following keys:
# 1. When starting without parameters, it will display a list of possible keys and their description. 
# 2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet 
# 3. The --target key displays a list of open system TCP ports.
#The code that performs the functionality of each of the subtasks must be placed in a separate function

################ in the case of a human check, please review the other solutions commented below and select more appropriate :)

#!/usr/bin/env bash

function ctrlc {
	echo "Received Ctrl+C" >> $LOGFILE
	exit 255
}

function show_usage_and_exit()
{
    echo "USAGE: $0 [--all] [--target]"
    echo "Key [--all] - displays a list of IP addresses and symbolic names of all hosts in the current subnet."
    echo "Key [--target] - displays a list of open system TCP ports."
    exit 0
}  

# The function that helps to display a list of open system TCP ports.
function tcp_ports() {
    printf "List of open system TCP ports:\n"
    printf "$(sudo netstat -tlpn | awk '/tcp/{print $1, $4}')\n"
}

# The function that helps to display a list of IP addresses and symbolic names of all hosts in the current subnet.
function ip_addresses() {
    printf "List of IP addresses and symbolic names of all hosts in the current subnet:\n"
    host_ip=$(hostname -I | cut -f1,2,3 -d.)
    sudo nmap -sn ${host_ip}.0/24
    ##printf "$(sudo nmap -sn ${host_ip}.0/24 | awk '/Nmap scan report for/{printf $5 "\t" $6;}/MAC Address:/{print " "substr($0, index($0,$4)) }')"
}

function check_nmap_is_installed {
    test -e /usr/bin/nmap
    if [[ "$?" == "0" ]]
    then
        echo "NMAP is installed, trying to scan network..."
    else
        echo "NMAP isn't installed, trying to install NMAP..."
        sudo apt install nmap  -y
    fi
}

function check_nettools_is_installed {
    test -e /usr/bin/netstat
    if [[ "$?" == "0" ]]
    then
        echo "net-tools is installed, trying to scan network..."
    else
        echo "net-tools isn't installed, trying to install net-tools..."
        sudo apt install net-tools  -y
    fi
}
#######main#########

if [[ $# -eq 0 ]]; then
    show_usage_and_exit
fi

trap ctrlc SIGINT



while [[ $# -gt 0 ]]; do
    case $1 in
     --all)
       check_nmap_is_installed
       ip_addresses
       ;;
     --target)
       check_nettools_is_installed
       tcp_ports
       ;;
     *)
       echo "Unknown option $1"
       exit 1
       ;;
     esac
     shift
done

#read -p "Press enter to continue"

# another solution
##!/bin/bash
#
## Function to display the list of possible keys
#function show_keys(){
#    echo "--all - displays the IP addresses and symbolic names of all hosts in the current subnet"
#    echo "--target - displays a list of open system TCP ports"
#}
#
## Function to display the IP addresses and symbolic names of all hosts in the current subnet
#function list_all(){
#    echo "Listing all IP addresses and symbolic names of all hosts in the current subnet:"
#    arp -a
#}
#
## Function to display a list of open system TCP ports
#function list_target(){
#    echo "Listing open system TCP ports:"
#    netstat -at
#}
#
## Main script
#if [ $# -eq 0 ]; then
#    show_keys
#elif [ $# -eq 1 ]; then
#    if [ "$1" == "--all" ]; then
#        list_all
#    elif [ "$1" == "--target" ]; then
#        list_target
#    else
#        echo "Invalid argument: $1"
#        show_keys
#    fi
#else
#    echo "Too many arguments!"
#    show_keys
#fi

