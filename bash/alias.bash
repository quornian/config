# Directory listing aliases
isaliased ll && unalias ll
ll() { ls -lph --color=always "$@" | sort --key=1.1,1.2 --stable; }
alias ls='ls --color=auto'
alias l='ll'
alias la='ll -A'

# Move to git root directory
alias cdg='cd `git rev-parse --show-cdup`'

# Calculator
alias calc='bc -lq'

# "Which" shortcuts
vw() { file="$(which "$1")" || return 1; vim "$file"; }
cw() { file="$(which "$1")" || return 1; cat "$file"; }
lw() { file="$(which "$1")" || return 1; ls -l "$file"; }

# Human readable, sorted disk usage
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
