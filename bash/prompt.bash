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
    local running="$(jobs | sed -nr 's/'"${pre}Running${post}"'/\2\&/p')"
    local stopped="$(jobs | sed -nr 's/'"${pre}Stopped${post}"'/\2^Z/p')"
    echo -e "$(__cx 31)$stopped $(__cx 32)$running" | tr '\n' ' '
}

# Function to join the parts together
function __make_prompt() {

    local ident="\[$(__cx "$__color_prompt_ident")\]\h:"
    local path="\[$(__cx "$__color_prompt_path")\]\w/"
    local git="\[$(__cx "$__color_prompt_git")\]\$(__prompt_git)"
    local job="\[$(__cx)\]\$(__prompt_jobs)"
    local prompt="\[$(__cx "$__color_prompt")\]\\$ \[$(__cx)\]"
    export PS1="\n${ident} ${path} ${git} ${job}\n${prompt}"
}

__make_prompt

