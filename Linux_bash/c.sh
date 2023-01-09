# C. Create a data backup script that takes the following data as parameters:
# 1. Path to the syncing  directory.
# 2. The path to the directory where the copies of the files will be stored.
# In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. 
# [The command to run the script must be added to crontab with a run frequency of one minute]


#!/usr/bin/env bash
RED='\033[31m'
Neutral='\033[0m'



function ctrlc {
	echo "Received Ctrl+C" >> $LOGFILE
	rm $TEMPFILE
  rm $PIDFILE
	exit 255
}

function show_usage_and_exit()
{

    echo -e "${RED}USAGE: $0 work_directory backup_directory${Neutral}"
    exit 0
}

function exit_from_script_with_error()
{
  rm $TEMPFILE
  rm $PIDFILE
  exit 1
}

######################  main  ######################
PIDFILE=/var/run/c.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi

if [ -z "$1" ] || [ -z "$2" ]; then
    show_usage_and_exit
fi

TEMPFILE="tempfile.txt"
> $TEMPFILE
LOGFILE="backuplog.txt"
> $LOGFILE
BACKUP_FROM=$1
BACKUP_TO=$2

trap ctrlc SIGINT

echo "Backup process starts at $(date +"%D %T")" >> $LOGFILE

if [ ! -d $BACKUP_FROM ]; then
	echo "There is no source directory... exiting" >> $LOGFILE
	exit_from_script_with_error
fi

if [ ! -d $BACKUP_TO ]; then
	echo "Creating backup directory" >> $LOGFILE
	if ! (mkdir $BACKUP_TO 2> /dev/null); then
		echo "Cant create backup directory" >> $LOGFILE
		exit_from_script_with_error
	fi
fi

###todo: check if backup dir not in source dir for exclude recursion copying

diff -r $BACKUP_FROM $BACKUP_TO | cut -f3,4 -d' '  >> $TEMPFILE

echo "Copying Files" >> $LOGFILE


cat $TEMPFILE | while read line
do
        file_name="$(echo $line | cut -d ' ' -f 2)"
        folder_name="$(echo $line | cut -d : -f 1)"
        if [[ "$folder_name" == "$BACKUP_FROM" ]]; then
            cp ${folder_name}/${file_name} $BACKUP_TO
            name=$(stat --format=%n ${folder_name}/${file_name} | rev | cut -d/ -f1 | rev)
            last_mod_time=$(date -r ${folder_name}/${file_name} "+%H:%M")
            printf "%20s\t%20s\t%20s\n" "File will be added" ${name} ${last_mod_time} >> $LOGFILE 
        
        elif [[ "$folder_name" == "$BACKUP_TO" ]]; then
            name=$(stat --format=%n ${folder_name}/${file_name} | rev | cut -d/ -f1 | rev)
            last_mod_time=$(date -r ${folder_name}/${file_name} "+%H:%M")
            printf "%20s\t%20s\t%20s\n" "File will be deleted" ${name} ${last_mod_time} >> $LOGFILE
        fi

done

# cp -v $BACKUP_FROM/* $BACKUP_TO >> $LOGFILE
rsync -avu --delete $BACKUP_FROM $BACKUP_TO   >> $LOGFILE

rm $TEMPFILE
rm $PIDFILE

echo "Backup finished at $(date +"%D %T")" >> $LOGFILE

#read -p "Press enter to continue"

