# Set the bash prompt including various indicators
#
# This includes things like the current git branch, background jobs, etc.
#

# Git branch indicator
function __prompt_git() {
    git rev-parse 2>/dev/null || return
    b=$(git branch | sed -n 's/^\* \(.*\)/\1/p')
    [ "$b" != "(no branch)" ] || b=$(git log -1 --pretty=%h)
    echo "[$b]"
}

# Background jobs indicator
function __prompt_jobs() {
    local pre='\[([0-9]+)\][-+]?\s+'
    local post='\s+([A-Za-z0-9_/]+).*'
    local names="$(jobs | sed -nr 's/'"${pre}${1}${post}"'/\2\&/p')"
    echo "$names" | tr '\n' ' '
}

# Function to join the parts together
function __make_prompt() {

    local ident="\[$(__cx "$__color_prompt_ident")\]\h:"
    local path="\[$(__cx "$__color_prompt_path")\]\w/"
    local git="\[$(__cx "$__color_prompt_git")\]\$(__prompt_git)"
    local jobinfo="\[$(__cx 31)\]\$(__prompt_jobs Stopped)"
    jobinfo="$jobinfo\[$(__cx 32)\]\$(__prompt_jobs Running)"
    local prompt="\[$(__cx "$__color_prompt")\]\\$ \[$(__cx)\]"
    export PS1="\n${ident} ${path} ${git} ${jobinfo}\n${prompt}"
}

__make_prompt

