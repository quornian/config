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

set-title() {
    # Use escape sequences for GNU screen and tmux
    if [[ -n "$TMUX" || -n "$STY" ]]
    then
        printf "\033k%s\033\\" "$1"
        printf "\033]0;$__host:%s\007" "$1"
    fi
}

signal-name() {
    if [[ -z "$exitcode" ]]
    then
        echo "Usage: signal-name SIGNAL_NUMBER"
    fi
    case "$1" in
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
    echo "$signame"
}

# Cached system values
__host="$(hostname | sed 's/\..*//')"
