# Colours for 256-colour terminals, sourced by color.bash
#

# Other program colour options
export GREP_COLORS="ms=01;34"
export LS_COLORS="\
fi=37:\
di=34:\
ow=34:\
ln=36:\
ex=1;37:\
mi=1;31:\
su=07:\
*.c=32:*.cpp=32:*.h=32:*.hpp=32:*.json=32:*.py=32"

# Colour options for the shell initialization
if [[ ! -z "$SSH_CONNECTION" ]]
then __color_prompt_ident="32"
else __color_prompt_ident="34"
fi
__color_prompt_path="38;5;8"
__color_prompt_git="33"
__color_prompt="38;5;15"
__color_exit="38;5;8"
__color_exit_error="38;5;9"

# Less colors for Man Pages
export LESS_TERMCAP_md=$'\e[1;36m'  # Begin bold
export LESS_TERMCAP_mb=$'\e[1;31m'  # Begin blinking
export LESS_TERMCAP_me=$'\e[m'      # End mode
export LESS_TERMCAP_so=$'\e[4;33m'  # Begin standout / info box
export LESS_TERMCAP_se=$'\e[m'      # End standout
export LESS_TERMCAP_us=$'\e[1m'     # Begin underline
export LESS_TERMCAP_ue=$'\e[m'      # End underline

