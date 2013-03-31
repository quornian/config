# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Palette
__c0="3A3A3A"; __c1="AF5F5F"; __c2="AFD75F"; __c3="FF8700"; # Bk Rd Gn Yl
__c4="00AFD7"; __c5="D787AF"; __c6="00AF87"; __c7="D7D7D7"; # Bu Mg Cy Gy
__c8="5F5F5F"; __c9="D75F5F"; __cA="D7FF5F"; __cB="FFAF00"; # Dk Rd Gn Yl
__cC="5FD7FF"; __cD="FF87D7"; __cE="5FD7AF"; __cF="FFFFFF"; # Bu Mg Cy Wt

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
# TODO: Investigate termcap for colour support
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
else
    source "$HOME/.bash/color-high.bash"
fi
