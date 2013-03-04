# Bash startup
#
# Sourced directly by non-login interactive shells. May be sourced
# indirectly for login shells via .bash_profile.
#

# Source system bashrc if it exists
test -f /etc/bashrc && source /etc/bashrc

# Source modules
source "$HOME/.bash/color.bash"
source "$HOME/.bash/prompt.bash"
source "$HOME/.bash/exec-hook.bash"
source "$HOME/.bash/keyboard.bash"
source "$HOME/.bash/function.bash"
source "$HOME/.bash/alias.bash"
source "$HOME/.bash/directory.bash"
test -f "$HOME/.bash/local.bash" && source "$HOME/.bash/local.bash"

# Allow editing of failed history substitutions
shopt -s histreedit
shopt -s histverify

# Save multi-line history properly
shopt -s cmdhist
shopt -s lithist

# Delete prior duplicates in history
export HISTCONTROL=ignorespace:erasedups
export HISTSIZE=15000
export HISTFILESIZE=15000
export HISTIGNORE="bg:fg:history"

# Set system default editor
export EDITOR=vim

# Better horizontal scrolling in less, with colours too
export LESS="-RS --shift=4"

# Local bin
export PATH="$HOME/bin:$HOME/scripts:$HOME/local/bin:$PATH"

# Set up pre-execution hook
preexec() {
    # Set title to command, if command is fg find current job command
    local cmd="$1"
    if [[ "$cmd" == "fg" ]]
    then
        cmd="$(jobs -r %% 2>/dev/null | sed -rn 's,.*(Running|Stopped)  +,,p')"
    fi
    set-title "($(substr "$cmd" 0 7)) $(substr "$(basename "$PWD/")" 0 5)"
    [[ -z "$__cmd_time" ]] && __cmd_time="$(date '+%s')"
}

# Set up post-execution hook
postexec() {
    local exitcode=$?
    if [[ $exitcode > 128 && $exitcode < 192 ]]
    then
        signame="$(signal-name $[exitcode - 128])"
    fi

    # Set title to directory or $TITLE
    [[ -z "$TITLE" ]] && set-title "$(substr "$PWD/" -15)" || \
        set-title "$TITLE"

    # Report the time the command took if greater than a threshold
    local t=$[ $(date '+%s') - __cmd_time ]
    if [[ $t > 3 || $exitcode != 0 ]]
    then
        if [[ $exitcode != 0 ]]
        then
            if [[ $exitcode > 128 && $exitcode < 192 ]]
            then
                echo -en " $(__cx "$__color_exit_error")[Terminated in $t "
                echo -en  "seconds at $(date '+%H:%M:%S') with signal "
                echo -e  "$[$exitcode - 128], $signame]\033[0m"
            else
                echo -en " $(__cx "$__color_exit_error")[Finished in $t "
                echo -en "seconds at $(date '+%H:%M:%S') with exit code "
                echo -e  "$exitcode]\033[0m"
            fi
        else
            echo -en " $(__cx "$__color_exit")[Finished in $t seconds "
            echo -e  "at $(date '+%H:%M:%S')]\033[0m"
        fi
    fi
    __cmd_time=
}
