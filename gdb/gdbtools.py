import gdb
import subprocess


def reset_term():
    show_cursor = "\x1b[?25h"
    reset_colors = "\x1b[m"
    clear_line = "\r\x1b[K"
    clear_screen = "\r\x1b[2J"
    print(show_cursor + reset_colors + clear_screen)


def current_line():
    frame = gdb.selected_frame()
    symtab_line = gdb.find_pc_line(frame.pc())
    line = symtab_line.line
    path = symtab_line.symtab.fullname()
    return path, line


def sync_to_vim():
    # First see if we have a running 'dbg' vim server
    check = subprocess.Popen(["vim", "--serverlist"], stdout=subprocess.PIPE)
    servers = check.communicate()[0].splitlines(False)
    if b"DBG" in servers:
        path, line = current_line()
        subprocess.call(["vim", "--servername", "DBG", "--remote", "+set cursorline | :%s" % line, path])
    else:
        print("No DBG vim server running. Start Vim as 'vim --servername DBG' to link up.")


