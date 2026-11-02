#!/bin/bash
SCRIPT_NAME=$(basename "$0") 
SCRIPT_DIR=$(dirname "$(readlink -f "$0")") 
if [ "$SCRIPT_NAME" = "template_task.sh" ]; then
	echo "Я бригадир, сам не работаю" 
	exit 0
fi

LOG_FILE="$SCRIPT_DIR/report_${SCRIPT_NAME%.sh}.log" 
FIFO="/tmp/cuckoo_fifo" 
REPLY_FIFO=$(mktemp -u "/tmp/cuckoo_reply_$$.XXXXXX") 
mkfifo "$REPLY_FIFO" || exit 1 
trap 'rm -f "$REPLY_FIFO"' EXIT 
DATE=$(date '+%Y-%m-%d %H:%M:%S') 
echo "$DATE [$$] Скрипт запущен" >> "$LOG_FILE" 

if [ ! -p "$FIFO" ]; then
	echo "Ошибка: канал кукушки не найден" >&2 
	exit 1 
fi 

echo "GET_TIME $REPLY_FIFO" > "$FIFO" 

if ! read -r SECONDS_TO_WAIT < "$REPLY_FIFO"; then
	echo "Ошибка: кукушка не ответила" >&2 
	exit 1 
fi 

if ! [[ "$SECONDS_TO_WAIT" =~ ^[0-9]+$ ]]; then
	echo "Ошибка: получено неверное время" >&2 
	exit 1 
fi 

sleep "$SECONDS_TO_WAIT" 

DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "$DATE [$$] Скрипт завершился, работал $SECONDS_TO_WAIT секунд." >> "$LOG_FILE"
