" Maintainer: Ian P. Thompson
" Version: 1.0
" Last Change: Friday 7th October 2011

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "terminal"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine     ctermbg=8
  hi CursorColumn   ctermbg=8
  hi MatchParen     ctermfg=10  ctermbg=8 cterm=bold
  hi Pmenu          ctermfg=15  ctermbg=8
  hi PmenuSel       ctermfg=0   ctermbg=2
endif

" General colors
hi Cursor                       ctermbg=241
hi Normal           ctermfg=7   ctermbg=0
hi NonText          ctermfg=7   ctermbg=235
hi LineNr           ctermfg=7   ctermbg=232
hi StatusLine       ctermfg=15  ctermbg=238 cterm=italic
hi StatusLineNC     ctermfg=7   ctermbg=238
hi VertSplit        ctermfg=7   ctermbg=238
hi Folded           ctermfg=7   ctermbg=4
hi Title            ctermfg=15  cterm=bold
hi Visual           ctermfg=15  ctermbg=4
hi SpecialKey       ctermfg=15  ctermbg=236

" Syntax highlighting
hi Comment          ctermfg=8
hi Todo             ctermfg=245
hi Boolean          ctermfg=2
hi String           ctermfg=2
hi Identifier       ctermfg=2
hi Function         ctermfg=255
hi Type             ctermfg=4
hi Statement        ctermfg=4
hi Keyword          ctermfg=3
hi Constant         ctermfg=3
hi Number           ctermfg=3
hi Special          ctermfg=3
hi PreProc          ctermfg=6

" Code-specific colors
hi pythonOperator   ctermfg=103

