#!/bin/sh

LOG_LEVEL_OFF=0
LOG_LEVEL_ERROR=10
LOG_LEVEL_WARN=20
LOG_LEVEL_INFO=30
LOG_LEVEL_DEBUG=40
LOG_LEVEL_ALL=99

if [ "$TAG" = "" ]; then
	TAG=$0
fi
if [ "$LOG_FILE" = "" ]; then
	LOG_FILE=./log.log
fi

output() { echo "$@" | tee -a $LOG_FILE; }
#output() { (echo "$@" | tee -a $LOG_FILE) & }

LOG() { output "[`date +"%F %T"`] [$TAG][$$] $@"; }
#[2014-02-23 21:51:29] DEBUG [FOO][3454] this is info log

if [ "$LOG_LEVEL" = "OFF" ]; then
	LOG_LEVEL=$LOG_LEVEL_OFF
elif [ "$LOG_LEVEL" = "ERROR" ]; then
	LOG_LEVEL=$LOG_LEVEL_ERROR
elif [ "$LOG_LEVEL" = "WARN" ]; then
	LOG_LEVEL=$LOG_LEVEL_WARN
elif [ "$LOG_LEVEL" = "INFO" ]; then
	LOG_LEVEL=$LOG_LEVEL_INFO
elif [ "$LOG_LEVEL" = "DEBUG" ]; then
	LOG_LEVEL=$LOG_LEVEL_DEBUG
elif [ "$LOG_LEVEL" = "ALL" ]; then
	LOG_LEVEL=$LOG_LEVEL_ALL
elif [ "$LOG_LEVEL" = "" ]; then
	LOG_LEVEL=$LOG_LEVEL_INFO
elif [ "$LOG_LEVEL" -eq "$LOG_LEVEL" 2>/dev/null ]; then
	LOG "LogLevel: $LOG_LEVEL"
else
	LOG "Wrong log level: $LOG_LEVEL"
	LOG_LEVEL=$LOG_LEVEL_INFO
fi

ERROR() { if [ $LOG_LEVEL -ge $LOG_LEVEL_ERROR ]; then output "[`date +"%F %T"`] ERROR [$TAG][$$] $@"; fi; }
WARN() { if [ $LOG_LEVEL -ge $LOG_LEVEL_WARN ]; then output "[`date +"%F %T"`] WARN [$TAG][$$] $@"; fi; }
INFO() { if [ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]; then output "[`date +"%F %T"`] INFO [$TAG][$$] $@"; fi; }
DEBUG() { if [ $LOG_LEVEL -ge $LOG_LEVEL_DEBUG ]; then output "[`date +"%F %T"`] DEBUG [$TAG][$$] $@"; fi; }


log_exec() { $@ | while read line; do LOG "$line"; done; }

# Performance test
#line=0; while [ $line -lt 10000 ]; do ERROR "this is error log" > /dev/null; line=`expr $line + 1`; done

#LOG "LogPath: $LOG_FILE LogLevel: $LOG_LEVEL Tag: $TAG"

#LOG "this is default log"
#DEBUG "this is debug log"
#INFO "this is info log"
#WARN "this is warnning log"
#ERROR "this is error log"

#log "$@"
#log_exec "$@"

