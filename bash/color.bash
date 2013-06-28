# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Palette
__c0="1B2426"; __c1="D9AE95"; __c2="B9BA91"; __c3="CCB48C"; # Bk Rd Gn Yl
__c4="AFBBB1"; __c5="C2B5B5"; __c6="ACBDA2"; __c7="9B9D98"; # Bu Mg Cy Gy
__c8="686A66"; __c9="F2C3A7"; __cA="CFD0A2"; __cB="E4C99C"; # Dk Rd Gn Yl
__cC="C3D0C6"; __cD="D7CACA"; __cE="C0D3B4"; __cF="CDD0C9"; # Bu Mg Cy Wt

export __c0 __c1 __c2 __c3 __c4 __c5 __c6 __c7
export __c8 __c9 __cA __cB __cC __cD __cE __cF

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
__cs="$(tput colors 2>/dev/null)"
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
    sleep 1; tput clear
else
    source "$HOME/.bash/color-high.bash"
fi
