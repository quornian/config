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
# Functions for applying colour to other programs
#

# Gnome-terminal
apply-terminal-palette() {
    local profile="/apps/gnome-terminal/profiles/Default"
    local palette="#$__c0:#$__c1:#$__c2:#$__c3:#$__c4:#$__c5:#$__c6:#$__c7"
    palette="$palette:#$__c8:#$__c9:#$__cA:#$__cB:#$__cC:#$__cD:#$__cE:#$__cF"
    gconftool-2 --type string --set "$profile/background_color" "#$__cbg"
    gconftool-2 --type string --set "$profile/foreground_color" "#$__cfg"
    gconftool-2 --type string --set "$profile/palette" "$palette"
    gconftool-2 --type string --set "$profile/cursor_blink_mode" "off"
}

# Xfce Terminal
apply-terminalrc() {
    cat > "$HOME/.terminalrc" <<END
[Configuration]
FontName=Monospace 9
FontAntiAlias=FALSE
ColorBackground=#$__c0
ColorForeground=#$__c7
ColorCursor=#$__c7
ColorPalette1=#$__c0
ColorPalette2=#$__c1
ColorPalette3=#$__c2
ColorPalette4=#$__c3
ColorPalette5=#$__c4
ColorPalette6=#$__c5
ColorPalette7=#$__c6
ColorPalette8=#$__c7
ColorPalette9=#$__c8
ColorPalette10=#$__c9
ColorPalette11=#$__cA
ColorPalette12=#$__cB
ColorPalette13=#$__cC
ColorPalette14=#$__cD
ColorPalette15=#$__cE
ColorPalette16=#$__cF
MiscAlwaysShowTabs=FALSE
MiscBell=FALSE
MiscBordersDefault=FALSE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscDefaultGeometry=150x30
MiscInheritGeometry=FALSE
MiscMenubarDefault=FALSE
MiscMouseAutohide=TRUE
MiscToolbarsDefault=FALSE
MiscConfirmClose=TRUE
MiscCycleTabs=TRUE
MiscTabCloseButtons=TRUE
MiscTabCloseMiddleClick=TRUE
MiscTabPosition=GTK_POS_TOP
MiscHighlightUrls=TRUE
END
}

