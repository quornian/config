" Project management ---------------------------------------------------

function! SaveProject()
    if isdirectory(".vimproject")
        " Customize what is saved to the project session
        set sessionoptions=buffers,curdir,folds,tabpages,winsize
        execute "mksession! .vimproject/session.vim"
    endif
endfunction

function! NewProject()
    if ! isdirectory(".vimproject")
        call mkdir(".vimproject")
    endif
    echo "Project created"
    if exists(":NERDTree")
        NERDTreeToggle
    endif
endfunction

function! LoadProject()
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

" Tag support ----------------------------------------------------------

function! GenerateTags()
    if ! isdirectory(".vimproject")
        echo "Not in a project"
        return
    endif
    execute "silent! !ctags --recurse --tag-relative -f .vimproject/tags * 2>/dev/null &"
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

