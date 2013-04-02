# Set the bash prompt including various indicators
#
# This includes things like the current git branch, background jobs, etc.
#

# Git branch indicator
function __prompt_git() {
    git rev-parse 2>/dev/null || return
    local branch=$(git branch | sed -n 's/^\* \(.*\)/\1/p')
    [ "$branch" != "(no branch)" ] || branch=$(git log -1 --pretty=%h)
    echo " [$branch]"
}

# Background jobs indicator
function __prompt_jobs() {
    # Usage: __prompt_jobs "Running|Stopped" suffix
    jobs | awk "/$1/ {printf \" %s$2\", \$3}"
}

# Function to join the parts together
function __make_prompt() {
    local ident="\[$(__cx "$__color_prompt_ident")\]\h:"
    local path="\[$(__cx "$__color_prompt_path")\]\w/"
    local git="\[$(__cx "$__color_prompt_git")\]\$(__prompt_git)"
    local jobinfo="\[$(__cx 32)\]\$(__prompt_jobs Running '&')"
    jobinfo="$jobinfo\[$(__cx 31)\]\$(__prompt_jobs Stopped '^Z')"
    local prompt="\[$(__cx "$__color_prompt")\]\\$ \[$(__cx 0)\]"
    export PS1="\n${ident} ${path}${git}${jobinfo}\n${prompt}"
}

__make_prompt

