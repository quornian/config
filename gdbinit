set history filename ~/.gdb/history
set history save on

python import os, sys
python sys.path.append(os.path.expanduser("~/.gdb"))
python import gdbtools

define hookpost-next
python gdbtools.sync_to_vim()
end
define hookpost-step
python gdbtools.sync_to_vim()
end
define hookpost-finish
python gdbtools.sync_to_vim()
end
define sync
python gdbtools.sync_to_vim()
end
define reset
python gdbtools.reset_term()
end

