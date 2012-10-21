# Linux framebuffer colour palette setup
echo -en "\e]P0000000" #black
echo -en "\e]P1CF8383" #darkred
echo -en "\e]P2668984" #darkgreen
echo -en "\e]P39B7E61" #brown
echo -en "\e]P43465A4" #darkblue
echo -en "\e]P575507B" #darkmagenta
echo -en "\e]P67CB8CE" #darkcyan
echo -en "\e]P7AAAAAA" #lightgrey
echo -en "\e]P8333333" #darkgrey
echo -en "\e]P9FF5555" #red
echo -en "\e]PAA6DAC4" #green
echo -en "\e]PBE3E373" #yellow
echo -en "\e]PC50AEFF" #blue
echo -en "\e]PDD378D3" #magenta
echo -en "\e]PE33AFDC" #cyan
echo -en "\e]PFFFFFFF" #white

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
