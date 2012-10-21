# Defines extension functions not provided by bash itself

isaliased() {
    alias | grep -q "^alias $1="
}

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
