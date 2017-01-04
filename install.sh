#!/usr/bin/env bash

dynmotd(){
    cp ./dynmotd/dynmotd.sh /usr/bin/dynmotd
    chmod +x /usr/bin/dynmotd
    echo "/usr/bin/dynmotd" >> /etc/profile
}

main(){
    if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 0
    fi
    
    dynmotd
}

main

