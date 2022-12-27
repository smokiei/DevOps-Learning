# B. Using Apache log example create a script to answer the following questions:
#   1. From which ip were the most requests?
#   2. What is the most requested page?
#   3. How many requests were there from each ip? 
#   4. What non-existent pages were clients referred to?  
#   5. What time did site get the most requests? 
#   6. What search bots have accessed the site? (UA + IP)

#!/usr/bin/env bash

function show_usage_and_exit()
{
    echo "\033[0;32m USAGE: $0 apache_log_file out_file \033[0m"
    echo "parse apache_log_file"
    exit 0
}  


function show_error_log_file_and_exit()
{
    echo "no or wrong logfile $1"
    exit 0
}

function log_parser_counter() #$1 = column to count
{
    column_number=$1 
    command_awk="{print $column_number}"
    awk -f <(echo "$command_awk") $INFILE | sort | uniq -c 
}

function ip_most_requests()
{
    echo "most requests came from this 10 IPs "
    echo -e "count\tIP"
    log_parser_counter "\$1" | sort -r | head
}


 function most_requested_page()
 {  
    echo "10 most requested page"
    echo -e "count\tPage"
    log_parser_counter "\$7" | sort -r | head 
 }


function cout_requests_from_each_ip () 
{
    echo "count requests from each ip"
    echo -e "count\tIP"
    log_parser_counter "\$1" | sort -r 
}

function time_most_requests ()
{
    echo "the site got most requests at that hour"
    echo -e "count of reqests\tDate:hour"
    #awk '{print $4}'  | cut -d/ -f3 | cut -d: -f2,3,4 | uniq -c | sort -n | tail -10
    #grep -Eo 25/Apr/2017:[0-9]{2}:[0-9]{2} $INFILE 
    grep -Eo 25/Apr/2017:[0-9]{2}: $INFILE |uniq -c | sort -r | head
}


function nonexistent_pages_referred ()
{  #| grep -v \ cut -d '"' -f 1,4 \
    grep " 404 " $INFILE \
     | awk '{print $7, $11}' \
     | grep -v " \"-\"" \
     | awk '{print $1}' \
     | sort \
     | uniq -c 
}


function bots_accessed_site()
{
    echo "bots accessed site"
    echo -e "IP\tBot"
    awk -F'"' '{print $1 $6}' $INFILE | grep -i 'bot' | sort -n | uniq #| sort -nr | head -30
}

######-----main-----######
if [ -z "$1" ] || [ -z "$2" ]; then
    show_usage_and_exit
fi

if [ ! -f "$1" ] ; then
    show_error_log_file_and_exit
fi

INFILE="$1"
OUTFILE="$2"

> $OUTFILE

ip_most_requests >> $OUTFILE

most_requested_page >> $OUTFILE

cout_requests_from_each_ip >> $OUTFILE

nonexistent_pages_referred >> $OUTFILE

time_most_requests >> $OUTFILE

bots_accessed_site >> $OUTFILE

#read -p "Press enter to continue"

