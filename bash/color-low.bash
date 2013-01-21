# Colours for 8- or 16-colour terminals, sourced by color.bash
#

# Linux framebuffer colour palette setup
if [[ -z "$LINUX_PALETTE_LOADED" ]]
then
    for x in {0..9} {A..F}
    do
        v="__c$x"
        echo -en "\e]P${x}${!v}"
    done
    export LINUX_PALETTE_LOADED=1
fi

# Other program colour options
export GREP_COLORS="ms=01;34"
export LS_COLORS="fi=37:di=33:ow=33:ln=36:ex=1:mi=34:su=07"

# Colour options for the shell initialization
if [[ ! -z "$SSH_CONNECTION" ]]
then __color_prompt_ident="32"
else __color_prompt_ident="34"
fi
__color_prompt_path="37"
__color_prompt_git="33"
__color_prompt=""
__color_exit="32"
__color_exit_error="31"
