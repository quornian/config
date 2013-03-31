# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Palette
__c0="444444"; __c1="5F0000"; __c2="AFD75F"; __c3="FF8700"; # Bk Rd Gn Yl
__c4="00AFD7"; __c5="D75FAF"; __c6="00AF87"; __c7="D7D7D7"; # Bu Mg Cy Gy
__c8="878787"; __c9="870000"; __cA="D7FF5F"; __cB="FFAF00"; # Dk Rd Gn Yl
__cC="5FD7FF"; __cD="FF87D7"; __cE="5FD7AF"; __cF="FFFFFF"; # Bu Mg Cy Wt

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
__cs="$(tput colors 2>/dev/null)"
if [[ "$__cs" = "256" ]]
then
    source "$HOME/.bash/color-high.bash"
else
    source "$HOME/.bash/color-low.bash"
    sleep 1; tput clear
fi
