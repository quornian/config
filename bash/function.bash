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
    # Use escape sequences for GNU screen and tmux
    if [[ -n "$TMUX" || -n "$STY" ]]
    then
        printf "\033k%s\033\\" "$1"
        printf "\033]0;$__host:%s\007" "$1"
    fi
}

# Return the name of a given signal
signal-name() {
    echo "SIG$(kill -l "$1")"
}

# Cached system values
__host="$(hostname | sed 's/\..*//')"
