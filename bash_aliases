#!/bin/bash
shopt -u expand_aliases

# Tie into the DEBUG event to get a zsh-like preexec hook
# A more complete version at: http://glyf.livejournal.com/63106.html
preexec() { :; }    # Default empty function
postexec() { :; }   # Default empty function
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # Completing, do nothing
    preexec "$(history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")";
}
trap 'preexec_invoke_exec' DEBUG
PROMPT_COMMAND='postexec'

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
function __color() {
    bgc="${1:0:1}"
    fgc="${1:1:1}"
    echo "\e[48;5;$(__color_num $bgc);38;5;$(__color_num $fgc)m"
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

# == Prompt ==

# Git indicator
function __ps1_git() {
    git rev-parse 2>/dev/null || return
    b=$(git branch | sed -n 's/^\* \(.*\)/\1/p')
    [ "$b" != "(no branch)" ] || b=$(git log -1 --pretty=%h)
    echo "[$b]"
}

# Function to join the parts together
function __make_prompt() {

    local ps1_ident="\
\[$(__color kb)\]\h:"

    local ps1_path="\
\[$(__color kK)\]\w"

    local ps1_git="\
\[$(__color ky)\]\$(__ps1_git)"

    local ps1_prompt="\
\[$(__color kW)\]\\$ \
\[$(__color kw)\]"

    export PS1="\n${ps1_ident} ${ps1_path} ${ps1_git}\n${ps1_prompt}"
}
__make_prompt

# == Keys ==

# History searching
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# == Aliases and Functions ==

# List aliases
alias ll='ls -lph --group-directories-first'
alias  l='ll'
alias la='ll -A'

# Calculator
alias calc='bc -lq'

# Shortcuts
vw() { vim "$(which "$1")"; }
cw() { cat "$(which "$1")"; }
view() { vim -MR "$1"; }

# == Settings ==

# Set system default editor
export EDITOR=vim

# Delete prior duplicates in history
export HISTCONTROL=ignorespace:erasedups

# Local bin
export PATH="$HOME/bin:$HOME/scripts:$HOME/local/bin:$HOME/config/bin:$PATH"

# Trying to execute a directory navigates into it
shopt -s autocd

# Completion
complete -o dirnames cd

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

# == Screen ==

# Settings specific to running bash in screen
if [ -n "$STY" ]
then
    __set_title() { printf "\033k%s\033\\" "$@"; }
    preexec() {
        #__set_title "\`$1\`"
        [ -z $__cmd_time ] && __cmd_time="$(date '+%s')"
    }
    postexec() {
        # Set title to directory or $TITLE
        [ -z "$TITLE" ] && __set_title "$(basename $(dirname "$PWD"))/$(basename "$PWD")/" || \
            __set_title "$TITLE"

        # Report the time the command took if greater than a threshold
        local t=$[ $(date '+%s') - __cmd_time ]
        if [ $t -gt 3 ]
        then
            echo -e "$(__color kK)[Finished in $t seconds at $(date '+%H:%M:%S')]\033[0m"
        fi
        __cmd_time=
    }
fi

