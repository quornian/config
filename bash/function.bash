# Defines extension functions not provided by bash itself
#

# Check if a given alias exists
isaliased() {
    alias | grep -q "^alias $1="
}

# A programmer-friendly substring function
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

# Set the tab/window title where supported
set-title() {
    if [[ -n "$TMUX" ]]
    then
        tmux rename-window -t $TMUX_PANE -- "$1"
    elif [[ -n "$STY" ]]
    then
        screen -X title "$1"
    fi
}

# Return the name of a given signal
signal-name() {
    if [[ "$1" > 0 ]] && [[ "$1" < 65 ]]
    then
        echo "SIG$(kill -l "$1")"
    else
        echo "UNKNOWN($1)"
    fi
}

# Cached system values
__host="$(hostname | sed 's/\..*//')"
