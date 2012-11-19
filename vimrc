" General settings
set showcmd         " Show the current partial command right of command line
set ruler           " Show the row,col combination
set splitbelow      " Make new split below the current one
set splitright      " Make new vsplits on the right (keep current on left)
set scrolloff=5     " Keep lines visible at top and bottom of screen
set background=dark
set laststatus=2    " Use an extra screen line to keep windows looking good
set history=500

" Swap and backups (the // means use full path with % in place of /)
set directory=~/.vim/swap//
set backupdir=~/.vim/backup

" Persistant undo between sessions (7.3 only)
if v:version >= 703
    set undofile
    set undodir=~/.vim/undo
endif

" Indentation
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Make backspace behave
set backspace=indent,eol,start
set softtabstop=4

" Folding
set foldmethod=indent
set nofoldenable
set nowrap
set diffopt=filler,context:3

" Filename autocompletion
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,.git
set wildmode=longest:full
set wildmenu

" General autocompletion                    " Only insert text common
set completeopt=menuone,longest,preview     " to all matches (longest)

" Search options
set incsearch       " Incremental search (ie. search as you type)
set report=0        " Report number of lines changed during search/replace
set ignorecase
set smartcase

" Mouse support
set mouse=nv
behave xterm

" Global clipboard
set clipboard=unnamedplus

" For when the global clipboard doesn't work
map <C-Y> :w ~/.vim/swap/clipboard
nmap <C-P> :read ~/.vim/swap/clipboard

" Zero-padded strings are not octal
set nrformats-=octal

" File type settings:
"  - filetype detection (implied)
"  - filetype-specific plugin loading
"  - filetype-specific indentation
filetype plugin indent on

" Restore last location in the file
autocmd! bufreadpost * silent! normal! `"

" Source the .vimrc immediately after you save it.
autocmd! bufwritepost .vimrc source %

" Read templates
au! BufNewFile * silent! 0r ~/.vim/template/%:e

" Colours
syntax enable
if &term == "linux"
    color colors_16
else
    set t_Co=256
    color mustang
endif

" Visible whitespace
set listchars=tab:>-,eol:~
hi SpecialKey cterm=NONE ctermfg=240 guifg=DarkRed
hi NonText cterm=NONE ctermfg=240 guifg=DarkRed

" Right margin
if v:version >= 703 && ! &diff
    set colorcolumn=73,74,75,76,77,78,79
endif

" Mappings
au BufRead,BufNewFile *.sdl,*.jdl set filetype=fcdl
au BufRead,BufNewFile *.ma set filetype=mel
au BufRead,BufNewFile *.def set filetype=tcl

" Get rid of toolbar, menu and scrollbars in gvim
"set guioptions-=T
"set guioptions-=m
"set guioptions-=r
set guioptions=
set gfn=Monospace\ 9

" Key mapping ----------------------------------------------------------------

" Set <leader> to ',' (comma).
let mapleader=','
nnoremap ; :

" Easy quit
nmap <leader>q :qa<CR>

" Select the text you just pasted
nnoremap <leader>v V`]

" Toggle line numbers (relative)
nmap <leader>l :if exists("+relativenumber") <Bar> :set relativenumber!
            \ <Bar> else <Bar> :set number! <Bar> endif <CR>
" Comment out a single line / range
nmap <leader># \c 
" Search for any line longer than 80 characters
nmap <leader>+ /.{81,}<CR>

" Replace all instances of word
nmap <leader>r :%s/\<<c-r>=expand("<cword>")<cr>\>//g
" Toggle highlighting of search terms
nmap <leader>k :set hls!<bar>set hls?<CR>
" Toggle visible whitespace
nmap <leader>w :set list!<CR>
" Toggle syntax
nmap <leader>syn :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar>
            \ syntax enable <Bar> endif <CR>
" Spell check
nmap <leader>sp :set spell!

" Explore the filesystem
nmap <F9> :Sexplore<CR>
" Toggle paste
nmap <leader>p :set paste!<Bar>set paste?<CR>
"imap <leader>p <Esc>:set paste!<Bar>set paste?<CR>a
" Maximize current split
nmap <leader>m <C-w><C-_>
" Browse for file to open
nmap <leader>b :browse split<CR>

" Easier way to jump between splits
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <C-Left> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Easier way to navigate wrapped text
map <Down> gj
map <Up> gk

" Easier way to increase / decrease the size of splits
map = <C-W>+
map - <C-W>-
map _ :split<CR>

" Save and quit from insert mode (stop :wq appearing in files)
iabbrev :w :w
"iabbrev :wq :wq

" I often hold shift that bit too long and type :Wq
command! W w
command! Q q
command! Qa qa
command! Wq wq

" Editing commands
command! Rstrip %s/\v +$//
command! -nargs=+ Grep execute 'silent grep! <args>' | copen 12 | redraw!

map zw zCzO
" Get the file under the cursor in a split
map gf :sp <cfile><CR>
" Change to the directory the current file is in
map <leader>cd :exe 'cd ' . expand ("%:p:h")<CR>
" This should soooo be what Y does (like D, innit?)
map Y y$

" Useful functions -----------------------------------------------------

function! RecoverDiff()
    save! /tmp/%
    vsplit
    bprev
    wincmd H
    windo diffthis
endfunction
command! RecoverDiff call RecoverDiff()

" Plugins --------------------------------------------------------------

" Manage plugin bundles with Pathogen
call pathogen#infect()  " Load bundle paths into vim
Helptags                " Update help

" Set up plugin options (which don't have adverse effects if the plugin
" isn't loaded)
let g:SuperTabDefaultCompletionType = "context"

" Set up bindings for plugins (should only be done for sucessfully
" loaded plugins)
function! SetupPlugins()

    " Files and directories tree
    if exists(":NERDTree")
        nnoremap <leader>t :NERDTreeFind<CR>
        autocmd bufenter * if (winnr("$") == 1 &&
            \ exists("b:NERDTreeType") &&
            \ b:NERDTreeType == "primary") | q | endif
        let g:NERDTreeMinimalUI = 1
        let g:NERDTreeQuitOnOpen = 1
        let g:NERDTreeWinPos = "right"
    endif

    " Undo tree
    if exists(":GundoToggle")
        nnoremap <leader>u :GundoToggle<CR>
    endif

    " Tagbar outline
    if exists(":TagbarToggle")
        nnoremap <leader>o :TagbarToggle<CR>
        let g:tagbar_autoclose = 1
        let g:tagbar_autofocus = 1
    endif

    " Syntax check
    if exists(":SyntasticCheck")
        nmap <leader>c :SyntasticCheck<CR>:Errors<CR>
    endif

endfunction
autocmd vimenter * call SetupPlugins()

" File type settings:
"  - filetype detection (implied)
"  - filetype-specific plugin loading
"  - filetype-specific indentation
filetype plugin indent on

" Manage plugin bundles with Pathogen
call pathogen#infect()

" Generate tags with: ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python*
set tags+=$HOME/.vim/tags/python.ctags
nmap <leader>] :execute "ltag " . expand("<cword>") <CR> :lopen <CR>
