" Maintainer:    Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:    September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine             ctermbg=8
  hi CursorColumn           ctermbg=6            
  hi ColorColumn ctermfg=2 ctermbg=none cterm=reverse
  hi MatchParen ctermfg=7   ctermbg=7       cterm=bold
  hi Pmenu      ctermfg=5   ctermbg=8            
  hi PmenuSel   ctermfg=0   ctermbg=8            
endif                                                                          
                                                                               
" General colors                                                               
hi Cursor                   ctermbg=0
hi Normal       ctermfg=7            
hi NonText      ctermfg=7            
hi LineNr       ctermfg=7   ctermbg=2
hi StatusLine   ctermfg=2   ctermbg=0       cterm=reverse
hi StatusLineNC ctermfg=2   ctermbg=6       cterm=reverse
hi VertSplit    ctermfg=2   ctermbg=0
hi Folded       ctermfg=2   ctermbg=6 
hi FoldColumn   ctermfg=2   ctermbg=6 
hi SignColumn   ctermfg=4   ctermbg=none
hi Title        ctermfg=4                   cterm=bold
hi Visual       ctermfg=4   ctermbg=4  
hi SpecialKey   ctermfg=4   ctermbg=6
                                                                               
" Syntax highlighting                                                          
hi Comment      ctermfg=2
hi Todo         ctermfg=0   ctermbg=2
hi Boolean      ctermfg=7
hi String       ctermfg=3
hi Number       ctermfg=6
hi Special      ctermfg=5
hi Identifier   ctermfg=5
hi Function     ctermfg=7
hi Type         ctermfg=4
hi Statement    ctermfg=4    "Things like class, hi, return
hi Keyword      ctermfg=5
hi Constant     ctermfg=6
hi PreProc      ctermfg=4
hi SpellBad                 ctermbg=7

" Code-specific colors
hi pythonOperator guifg=#7e8aa2 gui=none ctermfg=3

" Diff
hi DiffAdd                  ctermbg=2
hi DiffDelete   ctermfg=0   ctermbg=1
hi DiffChange               ctermbg=3
hi DiffText                 ctermbg=7

