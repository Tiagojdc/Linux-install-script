#!/usr/bin/env bash

#alias list
#Work directory
alias sl="ls $LS_OPTIONS"
alias ll="ls -lah"
alias l="ll"
alias c="cd"
alias dc="cd"
alias cd..="cd .."
alias k="cd .."

#Text editor
alias e="emacs"
alias v="vim"

#Tools

alias p="ps auxw"
alias pg="ps auxw | grep $GREP_OPTIONS"

#functions

function save(){
    if [ -z ${1} ]; then
	echo "Usage : save <file>"
    else
	SAVENAME="${1}.bak.$(date +%Y-%m-%d_%H-%M-%S)"
	cp -r ${1} ${SAVENAME}
	if [[ $? -ne 0 ]]; then
	    echo "File saved in ${SAVENAME}"
	fi
    fi
}



#functions export
export -f save
