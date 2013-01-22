# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Palette
__c0="000000"; __c1="AF0000"; __c2="AFD700"; __c3="FF8700";
__c4="5F87AF"; __c5="875F87"; __c6="008787"; __c7="AFAFAF";
__c8="5F5F5F"; __c9="D70000"; __cA="D7FF5F"; __cB="FFAF00";
__cC="5FAFFF"; __cD="D75FFF"; __cE="87D7D7"; __cF="FFFFFF";

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
# TODO: Investigate termcap for colour support
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
else
    source "$HOME/.bash/color-high.bash"
fi
