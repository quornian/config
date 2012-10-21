# Override terminal variable for tmux 256 colours (probably a bad idea)
export TERM="xterm-256color"

# Other program colour options
export GREP_COLORS="ms=01;34"
export LS_COLORS="fi=38;5;7:di=38;5;3:ow=38;5;3:ln=38;5;8:ex=38;5;15:mi=38;5;9:su=07"

# Colour options for the shell initialization
if [[ ! -z "$SSH_CONNECTION" ]]
then __color_prompt_ident="32"
else __color_prompt_ident="34"
fi
__color_prompt_path="38;5;8"
__color_prompt_git="33"
__color_prompt="38;5;15"
