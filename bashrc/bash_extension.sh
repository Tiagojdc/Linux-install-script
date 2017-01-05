#!/usr/bin/env bash


use_color=1

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

PROMPT_COMMAND=__prompt_command

function __prompt_command(){
    local EXIT=$?
    export PS1=""
    if [ ${EXIT} -ne 0 ]; then
        export PS1="[\[${RED}\]${EXIT}\[${RESET}\]]"
    fi

    if [[ $(id -u) != 0 ]]; then
	export PS1="${PS1}\[${CYAN}\]\u\[${RESET}\]@\[${GREEN}\]\h\[${RESET}\]: \[${BLUE}\]\w\[${RESET}\] > "
    else
        export PS1="${PS1}\[${RED}\]\u\[${RESET}\]@\[${GREEN}\]\h\[${RESET}\]: \[${BLUE}\]\w\[${RESET}\] > "
    fi
}

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