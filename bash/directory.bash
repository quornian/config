# A replacement for builtin cd that provides much more functionality
# while retaining backwards compatibility
#

# Known issues
#   cd ../foo sometimes just goes to .. if ../foo does not exist

# Trying to execute a directory navigates into it instead
shopt -s autocd

# Completion for cd
complete -o dirnames cd

# Override for builtin cd to manage history
cd() {
    case "$1" in

    -h|--help)
        echo "Usage:"
        echo "    /path/to/dir      Automatically runs cd /path/to/dir"
        echo "    cd /path/to/dir   Navigates to this directory, saving the current"
        echo "    cd /path/to/file  Navigates to the file's parent directory"
        echo "    cd -              Navigates to the previous directory or back again"
        echo "    cd --   (rd)      Navigates to the previous directory and pops it"
        echo "    cd ,              Prompt for frequency-based, full path completion"
        echo "    cdhist            Show the directory history"
        echo "    cd 1-99           Navigates to this entry in the history by number"
        echo "    cd @part          If $PWD is /aa/party/cc/dd navigates to /aa/party"
        echo ""
        builtin cd -h;;

    # Use "cd 4" to cd to the 4th entry in cdhist
    [1-9]|[1-9][0-9])
        local dir="$(cdhist $1)"
        if [[ -e "$1" || -z "$dir" ]]
        then cd "./$1"  # Might have directory named ./4/
        else cd "$(cdhist $1)"
        fi;;

    # Use "cd -" to swap between last two directories
    -) local prev="$PWD"; rd; __cdhist_push "$prev";;
    
    # Use "cd --" to restore the previous directory and pop it
    --) rd;;

    # Use "cd ," to run full-path completion
    ,) local p; p="$(cd.py suggest)" && cd "$p";;

    # Use "cd @*" to navigate up to first directory starting *
    @*)
        cd $(echo "$PWD" | sed -r "s_(.*/${1#@}[^/]*)/.*_\\1_");;
    
    # Otherwise cd to the location pushing the current directory first
    *)
        __cdhist_push "$PWD"

        # If it's a file, cd to its directory
        if [[ -f "$1" ]]; then builtin cd "$(dirname "$1")"

        # If it's a directory (or empty) use normal cd
        else builtin cd "$@"; fi;;
    esac

    # Finally record where we ended up in the frequency table
    cd.py record "$PWD"
}

# Restore last directory from history and pop the stack
rd() {
    # Something in the stack? Go there, then pop it off
    if [[ ! -z "$CDHIST" ]]; then builtin cd "${CDHIST##*:}"; __cdhist_pop; fi
}

# List directory history
cdhist() {
    local i=0
    echo "$CDHIST" | tr ':' '\n' | while read dir
    do
        i=$[i + 1]
        if [[ $1 -eq $i ]]; then echo "$dir"; break
        else if [[ -z "$1" ]]; then echo "$i $dir"; fi
        fi
    done
}

# Clear directory history
cdclear() {
    CDHIST=
}


# Internal functions

__cdhist_push() {
    # Empty? Just set equal
    if [[ -z "$CDHIST" ]]; then CDHIST="$1"; return; fi

    # Doesn't already have it? Append it
    if [[ "${CDHIST##*:}" != "$1" ]]; then CDHIST="$CDHIST:$1"; fi
}

__cdhist_pop() {
    # Remove the last entry
    CDHIST="${CDHIST%:*}"
}

