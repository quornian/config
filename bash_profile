#!/bin/bash
shopt -u expand_aliases

source "$HOME/.bash/color.bash"
source "$HOME/.bash/prompt.bash"
source "$HOME/.bash/exec-hook.bash"
source "$HOME/.bash/keyboard.bash"

isaliased() {
    alias | grep -q "^alias $1="
}


export LESS="-RS --shift=4"


# == Aliases and Functions ==

# List aliases
isaliased ll && unalias ll

# List, tag directories /, human readable, sorted with directories first
ll() { ls -lph --color=always "$@" | sort --key=1.1,1.2 --stable; }
alias ls='ls --color=auto'
alias l='ll'
alias la='ll -A'
duh() {
    du "$@" | sort -n | while read size fname
    do
        for unit in k M G T P E Z Y
        do
            if [ $size -lt 1024 ]
            then
                echo -e "${size}${unit}\t${fname}"
                break
            fi
            size=$((size/1024))
        done
    done
}

# Calculator
alias calc='bc -lq'

# Shortcuts
vw() { vim "$(which "$1")"; }
cw() { cat "$(which "$1")"; }
view() { vim -MR "$1"; }

# Functions
substr() { # $1 string, $2 start, $3 end
    local start=$2
    local end=$3
    [[ -z $start ]] && start=0
    [[ $start -lt 0 ]] && start=$[${#1} + $start]
    [[ $start -lt 0 ]] && start=0
    [[ -z $end ]] && end=${#1}
    [[ $end -lt 0 ]] && end=$[${#1} + $end]
    [[ $end -lt 0 ]] && end=0
    len=$[$end - $start]
    if [[ $len -gt 0 ]]
    then
        echo ${1:$start:$len}
    fi
}

# Directory management
source ~/.bash/directory_management
alias cdg='cd `git rev-parse --show-cdup`'

# == Settings ==

# Set system default editor
export EDITOR=vim

# Delete prior duplicates in history
export HISTCONTROL=ignorespace:erasedups

# Local bin
export PATH="$HOME/bin:$HOME/scripts:$HOME/local/bin:$HOME/config/bin:$PATH"

# Work / home customizations
if [ -f ~/.bash_aliases_work ]
then
    . ~/.bash_aliases_work
fi
if [ -f ~/.bash_aliases_home ]
then
    . ~/.bash_aliases_home
fi

shopt -s expand_aliases

# Allow editing of failed history substitutions
shopt -s histreedit
shopt -s histverify

# Save multi-line history properly
shopt -s cmdhist
shopt -s lithist

# == Screen ==

# Settings specific to running bash in screen
if [ -n "$STY" ]
then
    __host="$(hostname | sed 's/\..*//')"
    __set_title() {
        printf "\033k%s\033\\" "$1"
        printf "\033]0;$__host:%s\007" "$1"
    }
    preexec() {
        # Set title to command, if command is fg find current job command
        local cmd="$1"
        if [[ "$cmd" == "fg" ]]
        then
            cmd="$(jobs -r %% 2>/dev/null | sed -rn 's,.*(Running|Stopped)  +,,p')"
        fi
        __set_title "($(substr "$cmd" 0 7)) $(substr "$(basename "$PWD/")" 0 5)"
        [[ -z "$__cmd_time" ]] && __cmd_time="$(date '+%s')"
    }
    postexec() {
        local exitcode=$?
        if [[ $exitcode > 128 && $exitcode < 192 ]]
        then
            case $[exitcode - 128] in
             1) signame=SIGHUP;;   2) signame=SIGINT;;
             3) signame=SIGQUIT;;  4) signame=SIGILL;;
             5) signame=SIGTRAP;;  6) signame=SIGABRT;;
             7) signame=SIGBUS;;   8) signame=SIGFPE;;
             9) signame=SIGKILL;; 10) signame=SIGUSR1;;
            11) signame=SIGSEGV;; 12) signame=SIGUSR2;;
            13) signame=SIGPIPE;; 14) signame=SIGALRM;;
            15) signame=SIGTERM;; 16) signame=SIGSTKFLT;;
            17) signame=SIGCHLD;; 18) signame=SIGCONT;;
            19) signame=SIGSTOP;; 20) signame=SIGTSTP;;
            21) signame=SIGTTIN;; 22) signame=SIGTTOU;;
            23) signame=SIGURG;;  24) signame=SIGXCPU;;
            25) signame=SIGXFSZ;; 26) signame=SIGVTALRM;;
            27) signame=SIGPROF;; 28) signame=SIGWINCH;;
            29) signame=SIGIO;;   30) signame=SIGPWR;;
            31) signame=SIGSYS;;   *) signame=UNKNOWN;;
            esac
        fi

        # Set title to directory or $TITLE
        [[ -z "$TITLE" ]] && __set_title "$(substr "$PWD/" -15)" || \
            __set_title "$TITLE"

        # Report the time the command took if greater than a threshold
        local t=$[ $(date '+%s') - __cmd_time ]
        if [[ $t > 3 || $exitcode != 0 ]]
        then
            if [[ $exitcode != 0 ]]
            then
                if [[ $exitcode > 128 && $exitcode < 192 ]]
                then
                    echo -en " $(__color ky)[Terminated in $t seconds "
                    echo -en  "at $(date '+%H:%M:%S') with signal "
                    echo -e  "$[$exitcode - 128], $signame]\033[0m"
                else
                    echo -en " $(__color kr)[Finished in $t seconds "
                    echo -en "at $(date '+%H:%M:%S') with exit code "
                    echo -e  "$exitcode]\033[0m"
                fi
            else
                echo -en " $(__color kK)[Finished in $t seconds "
                echo -e  "at $(date '+%H:%M:%S')]\033[0m"
            fi
        fi
        __cmd_time=
    }
fi
