import os 
import time

pid = os.fork() 

if pid == 0: 
	print("Дочерний процесс:", os.getpid(), flush=True) 
	os._exit(0)
else: 
	print("Родительский процесс:", os.getpid(), flush=True) 
	print("PID дочернего процесса:", pid, flush=True)
	time.sleep(120)
