" Project management ---------------------------------------------------

" Saves the current session into the current project. No project will
" be created if it does not exist, use NewProject for this
function! SaveProject()
    if isdirectory(".vimproject")
        " Customize what is saved to the project session
        set sessionoptions=buffers,curdir,folds,tabpages,winsize
        execute "mksession! .vimproject/session.vim"
    endif
endfunction

" Creates a new project in the current directory, that is, a .vimproject
" directory will be created here
function! NewProject()
    if ! isdirectory(".vimproject")
        call mkdir(".vimproject")
    endif
    echo "Project created."
    if exists(":NERDTree")
        NERDTreeToggle
    endif
endfunction

" Loads a project from the current directory, if no project exists in
" the current directory but a project is defined further up, the current
" directory will be set to this first
function! LoadProject()
    call RootProject()
    if ! isdirectory(".vimproject")
        echo "Create project here? [y/N] "
        if nr2char(getchar()) == "y"
            call NewProject()
        else
            echo ""
            return
        endif
    elseif filereadable(".vimproject/session.vim")
        execute "so .vimproject/session.vim"
    endif
    call GenerateTags()
endfunction

" Finds the root directory of the project and makes this the current
" directory so that project files can be accessed via relative paths
function! RootProject()
    let s:path = fnamemodify(".", ":p:h")
    while s:path != "/"
        if isdirectory(s:path . "/" . ".vimproject")
            echo "Project found: " . s:path
            execute "cd " . s:path
            return
        endif
        let s:path = fnamemodify(s:path, ":h")
    endwhile
endfunction

" Executes any file called run.sh stored in the .vimproject directory
" allowing for custom build and execution scripts to be written
function! ExecuteProject()
    if ! isdirectory(".vimproject")
        return
    endif
    if ! filereadable(".vimproject/run.sh")
        silent !echo "\#\!/bin/sh" > ".vimproject/run.sh"
        silent !chmod +x ".vimproject/run.sh"
        split ".vimproject/run.sh"
    else
        !.vimproject/run.sh
    endif
endfunction

" Tag support ----------------------------------------------------------

" Generate or update a tags file for the current project and save it
" within the project data files
function! GenerateTags()
    if ! isdirectory(".vimproject")
        echo "Not in a project"
        return
    endif
    execute "silent! !ctags --recurse --tag-relative " .
          \ "-f .vimproject/tags * 2>/dev/null &"
    redraw!
endfunction

set tags+=.vimproject/tags

" Replace default Ctrl-] behaviour
nmap <leader>] :execute "ltag " . expand("<cword>") <CR> :lopen <CR>

" Registration ---------------------------------------------------------

" Only use project mode when opening Vim without any files
if argc() == 0
    autocmd VimLeave * call SaveProject()
    autocmd VimEnter * nested call LoadProject()
endif

