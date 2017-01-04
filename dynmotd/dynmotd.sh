#!/usr/bin/env bash

HOSTNAME=$(hostname)
IP_ADDRESS=$(ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' |  sed ':a;N;$!ba;s/\n/, /g')
KERNEL=$(uname -r)
SYSTEM=$(lsb_release -d | awk -F':' '{print $2}' | sed 's/^\s*//g')

CPU_INFO=$(echo $(more /proc/cpuinfo | grep processor | wc -l ) "x" $(more /proc/cpuinfo | grep 'model name' | uniq | awk -F:  '{print $2}'))

MEMORY=$(echo $(free -m |grep Mem: | awk -F " " '{print $2}') Mo)
MEMORY_USED=$(echo $(free -m |grep Mem: | awk -F " " '{print $3}') Mo)

DATE=$(date)

#UPTIME
UPTIME=$(</proc/uptime)
UPTIME=${UPTIME%%.*}
SECONDS=$(( UPTIME%60 ))
MINUTES=$(( UPTIME/60%60 ))
HOURS=$(( UPTIME/60/60%24 ))
DAYS=$(( UPTIME/60/60/24 ))


USER=$(whoami)
GROUP=$(groups)
LAST_LOGIN=$(echo $(last -a $USER | head -2 | awk 'NR==2{print $3,$4,$5,$6}') from $(last -a $USER | head -2 | awk 'NR==2{print $10}'))

SESSIONS=$(who | grep ${USER} | wc -l)
SCREEN=$(screen -ls)

PROCCOUNT=$( ps -Afl 2> /dev/null | wc -l )
PROCCOUNT=$( expr $PROCCOUNT - 5 )
 
echo -e "\033[1;32m 
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++
\033[0;35m+       \033[0;37mHostname \033[0;35m= \033[1;32m${HOSTNAME}
\033[0;35m+   \033[0;37mIPv4 Address \033[0;35m= \033[1;32m${IP_ADDRESS}
\033[0;35m+         \033[0;37mKernel \033[0;35m= \033[1;32m${KERNEL}
\033[0;35m+         \033[0;37mDistro \033[0;35m= \033[1;32m${SYSTEM}
\033[0;35m+         \033[0;37mUptime \033[0;35m= \033[1;32m${DAYS} days, ${HOURS} hours, ${MINUTES} minutes, ${SECONDS} seconds
\033[0;35m+           \033[0;37mTime \033[0;35m= \033[1;32m${DATE}
\033[0;35m+            \033[0;37mCPU \033[0;35m= \033[1;32m${CPU_INFO}
\033[0;35m+         \033[0;37mMemory \033[0;35m= \033[1;32m${MEMORY_USED} Used, ${MEMORY} Total
\033[0;35m+        \033[0;37mUpdates \033[0;35m= \033[1;32m${UPDATESAVAIL} "Updates Available" 
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++
\033[0;35m+      \033[0;37m Username \033[0;35m= \033[1;32m${USER}
\033[0;35m+      \033[0;37mUsergroup \033[0;35m= \033[1;32m${GROUP}
\033[0;35m+     \033[0;37mLast Login \033[0;35m= \033[1;32m${LAST_LOGIN}
\033[0;35m+       \033[0;37mSessions \033[0;35m= \033[1;32m${SESSIONS}
\033[0;35m+      \033[0;37mProcesses \033[0;35m= \033[1;32m${PROCCOUNT} of $(ulimit -u) max
\033[0;35m+        \033[0;37mScreens \033[0;35m= \033[1;32m${SCREEN}
\033[0;37m
"
