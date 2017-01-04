#!/usr/bin/env bash

use_color=1

function my_banner()
{
    width=$((25+${#1}))
    width_for_txt=$(($width-6))
    width=$(($width+1))

    divider="##############################################################################################"
    divider="$divider$divider"

    D="$1"
    BS=$width_for_txt
    L=$(((BS-${#D})/2))
    [ $L -lt 0 ] && L=0

    echo ${GREEN}
    printf "%$width.${width}s\n" "$divider"
    printf "## %$((${width}-6))s ##\n" ""
    printf "%s %${L}s %s %${L}s %s\n" "##" "" "$1" "" "##"
    printf "## %$((${width}-6))s ##\n" ""
    printf "%$width.${width}s\n" "$divider"
    echo ${WHITE}
}

function info()
{
    echo "[${GREEN}**${WHITE}] $@"
}

function error()
{
    if [ $# -ne 0 ]; then
        echo "[${RED}!!${WHITE}] $@"
    else
        echo "[${RED}!!${WHITE}] Unknow Error"
    fi

    exit 1
}


if [ ${use_color} -eq 1 ]; then
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    BLUE=`tput setaf 4`
    VIOLET=`tput setaf 5`
    CYAN=`tput setaf 6`
    WHITE=`tput setaf 7`
    GREY=`tput setaf 8`
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    VIOLET=""
    CYAN=""
    WHITE=""
    GREY=""
fi


dynmotd(){
    my_banner "install dynmotd"
    cp ./dynmotd/dynmotd.sh /usr/bin/dynmotd
    chmod +x /usr/bin/dynmotd
    echo "/usr/bin/dynmotd" >> /etc/profile
    info "install sucessfull"
}


install_dependencies(){
    my_banner "install dependencies"
    apt-get install -y emacs-nox cron-apt
    info "install sucessfull"
}

#function for clone emacs configuration
#function for setup bashrc

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 0
fi

install_dependencies
dynmotd
