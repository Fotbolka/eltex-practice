#!/bin/bash

source /home/user1/practice3/cron/observer.conf

DATE=$(date '+%Y-%m-%d %H:%M:%S')

if pgrep -f "$PROCESS_NAME" > /dev/null; then
	echo "$DATE | Process $PROCESS_NAME is running" >> "$LOG_FILE" 
else
	echo "$DATE | Process $PROCESS_NAME is NOT running" >> "$LOG_FILE"
fi
