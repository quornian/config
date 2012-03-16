" General settings
set showcmd         " Show the current partial command right of command line
set ruler           " Show the row,col combination
set splitbelow      " Make new split below the current one
set scrolloff=5     " Keep lines visible at top and bottom of screen
set background=dark
set laststatus=2    " Use an extra screen line to keep windows looking good
set history=500

" Swap and backups
set directory=~/.vim/swap
set backupdir=~/.vim/backup

" Persistant undo between sessions (7.3 only)
set undofile
set undodir=/tmp/undos

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

" Filename autocompletion
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc
set wildmode=longest:full
set wildmenu

" Search options
set incsearch       " Incremental search (ie. search as you type)
set report=0        " Report number of lines changed during search/replace
set ignorecase
set smartcase
" Use 'very magic' regular expressions when searching
nnoremap / /\v
vnoremap / /\v

" Mouse support
set mouse=nv
behave xterm

" Colours
syntax enable
set t_Co=256
colo mustang

" Visible whitespace
set list
set listchars=tab:↹-,eol:↵
hi SpecialKey cterm=NONE ctermfg=240 guifg=DarkRed
hi NonText cterm=NONE ctermfg=240 guifg=DarkRed

" Right margin
set colorcolumn=73,74,75,76,77,78,79
hi ColorColumn ctermbg=233 guibg=gray7

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

" Auto-close brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Select the text you just pasted
nnoremap <leader>v V`]

" Toggle line numbers (relative)
map ,l :if exists("+relativenumber") <Bar> :set relativenumber! <Bar> else <Bar> :set number! <Bar> endif <CR>
" Comment out a single line / range
map ,# \c 
" Search for any line longer than 80 characters
map ,+ /.{81,}<CR>

" Replace all instances of word
nmap ,r :%s/\<<c-r>=expand("<cword>")<cr>\>//g
" Toggle highlighting of search terms
map ,k :set hls!<bar>set hls?<CR>:PyflakesUpdate<CR>
" Toggle visible whitespace
nmap ,w :set list!<CR>
" Toggle syntax
map ,syn :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>
" Spell check
map ,sp :set spell!

" Explore the filesystem
map <F9> :Sexplore<CR>
" Toggle paste
map ,p :set paste!<Bar>set paste?<CR>
imap ,p <Esc>:set paste!<Bar>set paste?<CR>a
" Maximize current split
map ,m <C-w><C-_>

" Easier way to jump between splits
map <C-j> <C-w>j
map <C-k> <C-w>k
noremap <C-l> <C-w>l
map <C-h> <C-w>h

" Easier way to increase / decrease the size of splits
map + 5<C-W>+
map - 5<C-W>-
map <C-+> <C-W>+
map <C--> <C-W>-

map zw zCzO
" Get the file under the cursor in a split
map gf :sp <cfile><CR>
" Change to the directory the current file is in
map ,cd :exe 'cd ' . expand ("%:p:h")<CR>
" This should soooo be what Y does (like D, innit?)
map Y y$

" Global clipboard
set clipboard=unnamedplus

" File type settings:
"  - filetype detection (implied)
"  - filetype-specific plugin loading
"  - filetype-specific indentation
filetype plugin indent on
