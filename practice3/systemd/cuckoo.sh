#!/bin/bash

FIFO="/tmp/cuckoo_fifo"
if [ ! -p "$FIFO" ]; then
	mkfifo "$FIFO" 
fi 

echo "Cuckoo service started" 

while true; do
	if IFS=' ' read -r command reply_fifo < "$FIFO"; then 
		if [ "$command" = "GET_TIME" ] && [ -p "$reply_fifo" ]; then
			seconds=$((RANDOM % 10 + 1)) 

			echo "$seconds" > "$reply_fifo" 

			echo "$(date '+%Y-%m-%d %H:%M:%S') | Worker requested time: $seconds seconds"
		fi 
	fi 
done
