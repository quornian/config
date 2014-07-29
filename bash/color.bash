# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Palette
__c0="272822"; __c1="F92672"; __c2="A6E22E"; __c3="FD971F"; # Bk Rd Gn Yl
__c4="66BCEF"; __c5="AE81FF"; __c6="66D9EF"; __c7="708090"; # Bu Mg Cy Gy
__c8="708090"; __c9="F92672"; __cA="A6E22E"; __cB="FD971F"; # Dk Rd Gn Yl
__cC="66BCEF"; __cD="AE81FF"; __cE="66D9EF"; __cF="F8F8F2"; # Bu Mg Cy Wt
__cbg="181818"; __cfg="FFFFFF";

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
