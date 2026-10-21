#!/bin/bash

trap 'echo "Получен сигнал SIGINT"' SIGINT 
trap 'echo "Получен сигнал SIGTERM"; exit 0' SIGTERM 

echo "Скрипт запущен. PID: $$" 

while true; do
    sleep 2
done
