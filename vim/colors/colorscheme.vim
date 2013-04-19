" Maintainer:   Ian P. Thompson (ian@quornian.co.uk)
" Version:      1.0
" Last Change:  31 March 2013

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "colorscheme"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine                                     cterm=reverse
                \                                   gui=reverse
  hi CursorColumn                                   cterm=reverse
                \                                   gui=reverse
  hi ColorColumn    ctermfg=none    ctermbg=7       cterm=none
                \                   guibg=#D7D7D7   gui=none
  hi MatchParen     ctermfg=none    ctermbg=4       cterm=none
                \                   guibg=#00AFD7   gui=none
  hi Pmenu          ctermfg=0       ctermbg=7
                \   guifg=#444444   guibg=#D7D7D7
  hi PmenuSel       ctermfg=0       ctermbg=2
                \   guifg=#444444   guibg=#AFD75F
endif

" General colors
hi Cursor           ctermfg=7       ctermbg=0       cterm=reverse
                \   guifg=#D7D7D7   guibg=#444444   gui=reverse
hi Normal           ctermfg=7       ctermbg=0
                \   guifg=#D7D7D7   guibg=#444444
hi NonText          ctermfg=7       ctermbg=0
                \   guifg=#D7D7D7   guibg=#444444
hi LineNr           ctermfg=7       ctermbg=0
                \   guifg=#D7D7D7   guibg=#444444
hi Search           ctermfg=3       ctermbg=0       cterm=underline,bold
                \   guifg=#FF8700   guibg=#444444   gui=underline,bold
hi StatusLine       ctermfg=7       ctermbg=4       cterm=bold
                \   guifg=#FFFFFF   guibg=#00AFD7   gui=bold
hi StatusLineNC     ctermfg=7       ctermbg=6       cterm=none
                \   guifg=#D7D7D7   guibg=#00AF87   gui=none
hi TabLineFill      ctermfg=0       ctermbg=6       cterm=none
                \   guifg=#444444   guibg=#00AF87   gui=none
hi TabLine          ctermfg=7       ctermbg=6       cterm=none
                \   guifg=#D7D7D7   guibg=#00AF87   gui=none
hi TabLineSel       ctermfg=7       ctermbg=none    cterm=bold
                \   guifg=#FFFFFF                   gui=bold
hi VertSplit        ctermfg=7       ctermbg=7       cterm=none
                \   guifg=#D7D7D7   guibg=#D7D7D7   gui=none
hi Folded           ctermfg=0       ctermbg=7
                \   guifg=#444444   guibg=#D7D7D7
hi FoldColumn       ctermfg=7       ctermbg=0
                \   guifg=#D7D7D7   guibg=#444444
hi SignColumn       ctermfg=6       ctermbg=none
                \   guifg=#00AF87
hi Title            ctermfg=6                       cterm=bold
                \   guifg=#5FD7AF                   gui=bold
hi Visual           ctermfg=7       ctermbg=4       cterm=bold
                \   guifg=#FFFFFF   guibg=#00AFD7   gui=bold
hi SpecialKey       ctermfg=6       ctermbg=4
                \   guifg=#00AF87   guibg=#00AFD7

" Syntax highlighting
hi Comment          ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold
hi Todo             ctermfg=0       ctermbg=2
                \   guifg=#444444   guibg=#AFD75F
hi Boolean          ctermfg=7
                \   guifg=#D7D7D7
hi String           ctermfg=2
                \   guifg=#AFD75F
hi Number           ctermfg=4
                \   guifg=#00AFD7
hi Special          ctermfg=6
                \   guifg=#00AF87
hi Identifier       ctermfg=6
                \   guifg=#00AF87
hi Function         ctermfg=7
                \   guifg=#D7D7D7
hi Type             ctermfg=6
                \   guifg=#00AF87
hi Statement        ctermfg=4                       cterm=bold
                \   guifg=#5FD7FF                   gui=bold
hi Keyword          ctermfg=4
                \   guifg=#00AFD7
hi Constant         ctermfg=4
                \   guifg=#00AFD7
hi PreProc          ctermfg=4                       cterm=bold
                \   guifg=#5FD7FF                   gui=bold
hi SpellBad                         ctermbg=7
                \                   guibg=#D7D7D7

" Diff
hi DiffAdd                          ctermbg=2
                \                   guibg=#AFD75F
hi DiffDelete       ctermfg=0       ctermbg=1
                \   guifg=#444444   guibg=#AF5F5F
hi DiffChange                       ctermbg=3
                \                   guibg=#FF8700
hi DiffText                         ctermbg=7
                \                   guibg=#D7D7D7

" Git
hi diffAdded        ctermfg=2
                \   guifg=#AFD75F
hi diffRemoved      ctermfg=1
                \   guifg=#AF5F5F
hi diffFile         ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold
hi diffSubname      ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold
hi gitcommitDiff    ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold
hi gitcommitBranch  ctermfg=3
                \   guifg=#FF8700
hi gitcommitFile    ctermfg=4
                \   guifg=#00AFD7
hi gitcommitType    ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold
hi gitcommitOverflow ctermfg=6
                \   guifg=#00AF87
hi gitcommitSummary ctermfg=7
                \   guifg=#D7D7D7

" Language specifics
hi vimCommentTitle  ctermfg=0                       cterm=bold
                \   guifg=#878787                   gui=bold

" Highlight trailing whitespace on non-blank lines
hi WhitespaceError  ctermfg=0       ctermbg=0       cterm=underline,bold
                \   guifg=#444444   guibg=#444444   gui=underline,bold
match WhitespaceError /\S\@<=\s\+$\|\t/

" When 256 is available, modify *some* colors but keep most consistent
" we rely instead on the terminal palette
if &term != "linux"
  set t_Co=256
  hi CursorLine                     ctermbg=236     cterm=none
                \                   guibg=#303030   gui=none
  hi CursorColumn                   ctermbg=236
                \                   guibg=#303030
  hi ColorColumn                    ctermbg=237
                \                   guibg=#3A3A3A
  hi VertSplit      ctermfg=236     ctermbg=236
                \   guifg=#303030   guibg=#303030
  hi StatusLine                     ctermbg=240
                \                   guibg=#5A5A5A
  hi StatusLineNC                   ctermbg=236
                \                   guibg=#303030

  " Diff
  hi DiffAdd                        ctermbg=236
                \                   guibg=#303030
  hi DiffDelete     ctermfg=235     ctermbg=none
                \   guifg=#262626
  hi DiffChange                     ctermbg=235
                \                   guibg=#262626
  hi DiffText                       ctermbg=236
                \                   guibg=#303030
  hi Folded         ctermfg=240     ctermbg=234
                \   guifg=#5A5A5A   guibg=#1C1C1C
endif
