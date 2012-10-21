#!/bin/bash
shopt -u expand_aliases

source "$HOME/.bash/exec-hook.bash"

isaliased() {
    alias | grep -q "^alias $1="
}

# == Colours ==

# The following table matches GNU screen colour codes to
# colour escape sequence values for use in the prompt:
#   0:k black         8:K dark grey
#   1:r red           9:R bright red
#   2:g green        10:G bright green
#   3:y yellow       11:Y bright yellow
#   4:b blue         12:B bright blue
#   5:m magenta      13:M bright magenta
#   6:c cyan         14:C bright cyan
#   7:w light grey   15:W white
function __color_num() {
    case $1 in
        k) n=0 ;; r) n=1 ;; g) n=2 ;; y) n=3 ;;
        b) n=4 ;; m) n=5 ;; c) n=6 ;; w) n=7 ;;
        K) n=8 ;; R) n=9 ;; G) n=10;; Y) n=11;;
        B) n=12;; M) n=13;; C) n=14;; W) n=15;;
        *) echo "Bad Colour: $1" 1>&2 ;  n=9 ;;
    esac
    echo $n
}

# Turns a colour code (eg. kW) into a colour escape sequence
if [[ "$TERM" = "linux" && "$__colors_set" != "yes" ]]
then
    echo -en "\e]P0000000" #black
    echo -en "\e]P1CF8383" #darkred
    echo -en "\e]P2668984" #darkgreen
    echo -en "\e]P39B7E61" #brown
    echo -en "\e]P43465A4" #darkblue
    echo -en "\e]P575507B" #darkmagenta
    echo -en "\e]P67CB8CE" #darkcyan
    echo -en "\e]P7AAAAAA" #lightgrey
    echo -en "\e]P8333333" #darkgrey
    echo -en "\e]P9FF5555" #red
    echo -en "\e]PAA6DAC4" #green
    echo -en "\e]PBE3E373" #yellow
    echo -en "\e]PC50AEFF" #blue
    echo -en "\e]PDD378D3" #magenta
    echo -en "\e]PE33AFDC" #cyan
    echo -en "\e]PFFFFFFF" #white
    clear
    __colors_set="yes"

    function __color() {
        if [[ ${#1} == 1 ]]
        then
            local bgc="$(__color_num "k")"
            local fgc="$(__color_num "$1")"
        else
            local bgc="$(__color_num "${1:0:1}")"
            local fgc="$(__color_num "${1:1:1}")"
        fi
        local pre="0;3"
        if [[ "$bgc" > 7 ]]
        then
            bgc="$[bgc - 8]"
        fi
        if [[ "$fgc" > 7 ]]
        then
            fgc="$[fgc - 8]"
            pre="1;3"
        fi
        echo -e "\e[${pre}${fgc};4${bgc}m"
    }

    export GREP_COLORS="ms=01;34"
    export LS_COLORS="\
fi=37:\
di=33:\
ow=33:\
ln=36:\
ex=1:\
mi=34:\
su=07"
else
    export TERM="xterm-256color"
    function __color() {
        if [[ ${#1} == 1 ]]
        then
            fgc=$1
            echo "\e[38;5;$(__color_num $fgc)m"
        else
            bgc="${1:0:1}"
            fgc="${1:1:1}"
            echo "\e[48;5;$(__color_num $bgc);38;5;$(__color_num $fgc)m"
        fi
    }
    export GREP_COLORS="ms=01;34"
    export LS_COLORS="\
fi=38;5;7:\
di=38;5;3:\
ow=38;5;3:\
ln=38;5;8:\
ex=38;5;15:\
mi=38;5;9:\
su=07"
fi

export LESS="-RS --shift=4"

# == Prompt ==

# Git indicator
function __ps1_git() {
    git rev-parse 2>/dev/null || return
    b=$(git branch | sed -n 's/^\* \(.*\)/\1/p')
    [ "$b" != "(no branch)" ] || b=$(git log -1 --pretty=%h)
    echo "[$b]"
}

function __ps1_jobs() {
    local pre='\[([0-9]+)\][-+]?\s+'
    local post='\s+([A-Za-z0-9_/]+).*'
    local running="$(jobs | sed -nr 's/'"${pre}Running${post}"'/\2\&/p')"
    local stopped="$(jobs | sed -nr 's/'"${pre}Stopped${post}"'/\2^Z/p')"
    echo -e "$(__color r)$stopped $(__color g)$running" | tr '\n' ' '
}

# Set colour scheme differently for ssh
if [[ ! -z "$SSH_CONNECTION" ]]
then
    export THEME_FG=g
else
    export THEME_FG=b
fi

# Function to join the parts together
function __make_prompt() {

        local ps1_ident="\
\[$(__color $THEME_FG)\]\h:"

    local ps1_path="\
\[$(__color K)\]\w/"

    local ps1_git="\
\[$(__color y)\]\$(__ps1_git)"

    local ps1_jobs="\
\[$(__color g)\]\$(__ps1_jobs)"

    local ps1_prompt="\
\[$(__color W)\]\\$ \
\[$(__color w)\]"

    export PS1="\n${ps1_ident} ${ps1_path} ${ps1_git} ${ps1_jobs}\n${ps1_prompt}"
}
__make_prompt

# == Keys ==

# History searching
case "$-" in
*i*)
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    ;;
esac

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

# Set key repeat for X. For the linux framebuffer, set the following in
# /etc/rc.local: kbdrate -s -r200 -d50 >/dev/null
xset r rate 200 50 2>/dev/null
