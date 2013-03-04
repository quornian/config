" Maintainer:   Ian P. Thompson (ian@quornian.co.uk)
" Version:      1.0
" Last Change:  21 January 2013

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "colorscheme"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine                             cterm=reverse
  hi CursorColumn                           cterm=reverse
  hi ColorColumn ctermfg=none ctermbg=7     cterm=none
  hi MatchParen ctermfg=none ctermbg=4      cterm=none
  hi Pmenu      ctermfg=0   ctermbg=7
  hi PmenuSel   ctermfg=0   ctermbg=2
endif

" General colors
hi Cursor       ctermfg=7   ctermbg=0       cterm=reverse
hi Normal       ctermfg=7
hi NonText      ctermfg=7
hi LineNr       ctermfg=7   ctermbg=8
hi Search       ctermfg=3   ctermbg=0       cterm=underline,bold
hi StatusLine   ctermfg=7   ctermbg=4       cterm=bold
hi StatusLineNC ctermfg=7   ctermbg=6       cterm=none
hi TabLineFill  ctermfg=0   ctermbg=6       cterm=none
hi TabLine      ctermfg=7   ctermbg=6       cterm=none
hi TabLineSel   ctermfg=7   ctermbg=none    cterm=bold
hi VertSplit    ctermfg=7   ctermbg=7       cterm=none
hi Folded       ctermfg=0   ctermbg=7
hi FoldColumn   ctermfg=7   ctermbg=0
hi SignColumn   ctermfg=6   ctermbg=none
hi Title        ctermfg=6                   cterm=bold
hi Visual       ctermfg=7   ctermbg=4       cterm=bold
hi SpecialKey   ctermfg=6   ctermbg=4

" Syntax highlighting
hi Comment      ctermfg=0                   cterm=bold
hi Todo         ctermfg=0   ctermbg=2
hi Boolean      ctermfg=7
hi String       ctermfg=2
hi Number       ctermfg=4
hi Special      ctermfg=5
hi Identifier   ctermfg=6
hi Function     ctermfg=7
hi Type         ctermfg=6
hi Statement    ctermfg=4  cterm=bold   "Things like class, hi, return
hi Keyword      ctermfg=5
hi Constant     ctermfg=4
hi PreProc      ctermfg=4   cterm=bold
hi SpellBad                 ctermbg=7

" Diff
hi DiffAdd                  ctermbg=2
hi DiffDelete   ctermfg=0   ctermbg=1
hi DiffChange               ctermbg=3
hi DiffText                 ctermbg=7

" Language specifics
hi vimCommentTitle ctermfg=7                cterm=bold

" When 256 is available, modify *some* colors but keep most consistent
" we rely instead on the terminal palette
if &term != "linux"
    set t_Co=256
    hi CursorLine           ctermbg=236     cterm=none
    hi CursorColumn         ctermbg=236
    hi ColorColumn          ctermbg=233
    hi VertSplit ctermfg=236 ctermbg=236
    hi StatusLine           ctermbg=240
    hi StatusLineNC         ctermbg=236

    " Diff
    hi DiffAdd              ctermbg=236
    hi DiffDelete ctermfg=235 ctermbg=none
    hi DiffChange           ctermbg=235
    hi DiffText             ctermbg=236
    hi Folded   ctermfg=240 ctermbg=234

    " Fix for disappearing cursor when over light-black on black
    hi Comment  ctermfg=59                  cterm=bold
endif
