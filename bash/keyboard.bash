# Keyboard settings for the shell
#

# Set key repeat for X
# For the linux framebuffer, set the following in /etc/rc.local:
# kbdrate -s -r200 -d50 >/dev/null  (has to be run as root)
xset r rate 200 50 2>/dev/null

# Bind up and down arrows to history searching
case "$-" in
*i*)
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    ;;
esac
