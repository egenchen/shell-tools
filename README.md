# shell-tools
Some useful shell tools

log.sh
SHELL logging library.

Output the following log format:
[date] log_level [module][pid] log detail
```
[2014-02-23 21:51:29] DEBUG [FOO][3454] this is info log
```

Variables:
$TAG: The tag of the module, default is the script name.
$LOG_FILE: File path of the log, default: ./log.log.
$LOG_LEVEL: The log level. Available log level: OFF, ERROR, WARN, INFO, DEBUG, ALL.

Usage:
```
TAG="FOO"
LOG_LEVEL="ALL"
LOG_FILE="mylog.log"
. ./log.sh

LOG "this is default log"
DEBUG "this is debug log"
INFO "this is info log"
WARN "this is warnning log"
ERROR "this is error log"
```

