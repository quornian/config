# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
# TODO: Investigate termcap for colour support
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
else
    source "$HOME/.bash/color-high.bash"
fi
