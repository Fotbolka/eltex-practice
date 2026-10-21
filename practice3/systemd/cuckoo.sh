#!/bin/bash
FIFO="/tmp/cuckoo_fifo" 

if [ ! -p "$FIFO" ]; then 
	mkfifo "$FIFO" 
fi 

while true; do 
	if read -r message < "$FIFO"; then
        	echo "$(date '+%Y-%m-%d %H:%M:%S') | $message" 
	fi
done
