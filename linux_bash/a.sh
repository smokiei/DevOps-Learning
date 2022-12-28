# A. Create a script that uses the following keys:
# 1. When starting without parameters, it will display a list of possible keys and their description. 
# 2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet 
# 3. The --target key displays a list of open system TCP ports.
#The code that performs the functionality of each of the subtasks must be placed in a separate function

#!/usr/bin/env bash

function show_usage_and_exit()
{
    echo "USAGE:  $0 [--all] [--target]"
    echo "Key [--all] - displays a list of IP addresses and symbolic names of all hosts in the current subnet."
    echo "Key [--target] - displays a list of open system TCP ports."
    echo -e "\033[0m"
    #exit 0
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
        printf "$(sudo nmap -sn ${host_ip}.0/24 | awk '/Nmap scan report for/{printf $5 "\t" $6;}/MAC Address:/{print " "substr($0, index($0,$4)) }')"
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

if [[ $# -eq 0 ]]; then
        show_usage_and_exit
fi

check_nmap_is_installed

while [[ $# -gt 0 ]]; do
  case $1 in
    --all)
      ip_addresses
      ;;
    --target)
      tcp_ports
      ;;
    *)
      echo "Unknown option $1"
      #exit 1
      ;;
  esac
  shift
done


# read -p "Press enter to continue"


# todo :
# -select interface
# -select scan method nmap or else
# -scan fork

# for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
# do
#         echo -n -e '\033[0;31m'$interface'\033[0m':'\033[0;35m'$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')'\033[0m'
#         for interf in $default
#         do
#                 if [ $interf = $interface ]
#                 then
#                         echo -n -e ':\033[0;32mdefault\033[0m'
#                         break
#                 fi
#         done
#         echo
# done

# is_alive_ping()
# {
#   ping -c 1 $1 > /dev/null
#   [ $? -eq 0 ] && echo $i,Up
#   [ $? -eq 1 ] && echo $i,Down
# }

# for i in 10.1.150.{1..10}
# do
# is_alive_ping $i & disown
# done

 
# LOG=/tmp/mylog.log 
# SECONDS=3600 
# EMAIL=my@email.address 
# for i in $@; do 
# 	echo "$i-UP!" > $LOG.$i 
# done 
# while true; do 
# 	for i in $@; do 
# ping -c 1 $i > /dev/null 
# if [ $? -ne 0 ]; then 
# 	STATUS=$(cat $LOG.$i) 
#  		if [ $STATUS != "$i-DOWN!" ]; then 
#  			echo "`date`: ping failed, $i host is down!" | 
# 			mail -s "$i host is down!" $EMAIL 
#  		fi 
# 	echo "$i-DOWN!" > $LOG.$i 
# else 
# 	STATUS=$(cat $LOG.$i)
#  		if [ $STATUS != "$i-UP!" ]; then 
#  			echo "`date`: ping OK, $i host is up!" | 
# 			mail -s "$i host is up!" $EMAIL
#  		fi 
# 	echo "$i-UP!" > $LOG.$i 
# fi 
# done 
# sleep $SECONDS 
# done
# default=`ip r | grep default | awk '{print $5}'`






#
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

