#!/usr/bin/env bash
if [ ! ${TERM} = "unknown" ]; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    VIOLET=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    GREY=$(tput setaf 8)
    RESET=$(tput sgr0)
    BOLD=$(tput bold)


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

    PROCCOUNT=$(ps -Afl 2> /dev/null | wc -l)
    PROCCOUNT=$(expr $PROCCOUNT - 5)

    toilet -f mono12 -F metal $(hostname -s)
#/usr/games/fortune /usr/share/games/fortunes/fr/informatique | boxes -d cat -a hc -p h8 | /usr/games/lolcat
    /usr/games/cowsay $(/usr/games/fortune /usr/share/games/fortunes/fr/informatique) | /usr/games/lolcat
    echo -e "
    ${BOLD}${CYAN}+++++++++++++++++: ${RESET}System Data${CYAN}${BOLD} :+++++++++++++++++++
    ${CYAN}+       ${RESET}Hostname ${CYAN}= ${GREEN}${BOLD}${HOSTNAME}
    ${CYAN}+   ${RESET}IPv4 Address ${CYAN}= ${GREEN}${BOLD}${IP_ADDRESS}
    ${CYAN}+         ${RESET}Kernel ${CYAN}= ${GREEN}${BOLD}${KERNEL}
    ${CYAN}+         ${RESET}Distro ${CYAN}= ${GREEN}${BOLD}${SYSTEM}
    ${CYAN}+         ${RESET}Uptime ${CYAN}= ${GREEN}${BOLD}${DAYS} days, ${HOURS} hours, ${MINUTES} minutes, ${SECONDS} seconds
    ${CYAN}+           ${RESET}Time ${CYAN}= ${GREEN}${BOLD}${DATE}
    ${CYAN}+            ${RESET}CPU ${CYAN}= ${GREEN}${BOLD}${CPU_INFO}
    ${CYAN}+         ${RESET}Memory ${CYAN}= ${GREEN}${BOLD}${MEMORY_USED} Used / ${MEMORY} Total
    ${BOLD}${CYAN}++++++++++++++++++: ${RESET}User Data${BOLD}${CYAN} :++++++++++++++++++++
    ${CYAN}+       ${RESET}Username ${CYAN}= ${GREEN}${BOLD}${USER}
    ${CYAN}+      ${RESET}Usergroup ${CYAN}= ${GREEN}${BOLD}${GROUP}
    ${CYAN}+     ${RESET}Last Login ${CYAN}= ${GREEN}${BOLD}${LAST_LOGIN}
    ${CYAN}+       ${RESET}Sessions ${CYAN}= ${GREEN}${BOLD}${SESSIONS}
    ${CYAN}+      ${RESET}Processes ${CYAN}= ${GREEN}${BOLD}${PROCCOUNT} of $(ulimit -u) max
    ${CYAN}+        ${RESET}Screens ${CYAN}= ${GREEN}${BOLD}${SCREEN}
    ${RESET}
    "
fi