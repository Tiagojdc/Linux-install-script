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
    my_banner "Install dynmotd"
    cp ./dynmotd/dynmotd.sh /usr/bin/dynmotd
    chmod +x /usr/bin/dynmotd
    grep -qe '/usr/bin/dynmotd' /etc/profile
    if [ $? -ne 0 ]; then
	echo "/usr/bin/dynmotd" >> /etc/profile
    fi
    info "install sucessfull"
}

install_dependencies_debian(){
    my_banner "Install dependencies"
    apt-get install -y \
	emacs-nox \
	cron-apt \
	fail2ban \
	fortune \
	fortunes-fr \
	cowsay \
	lolcat \
	toilet
    info "install sucessfull"
}

setup_bashrc(){
    my_banner "Setup bashrc"
    cp ./bashrc/bash_extension.sh /etc/bash_extension

    grep -qe 'source /etc/bash_extension' /etc/bash.bashrc
    if [ $? -ne 0 ]; then
	echo 'source /etc/bash_extension' >> /etc/bash.bashrc
    fi
    info "Install successfull"
	
}
#function for clone emacs configuration

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 0
fi

install_dependencies_debian
dynmotd
setup_bashrc

info "install successfully finished"