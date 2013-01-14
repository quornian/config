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
  hi CursorLine               guibg=#303030             ctermbg=236 term=None   cterm=None
  hi CursorColumn             guibg=#303030             ctermbg=236
  hi ColorColumn              guibg=#121212             ctermbg=233
  hi MatchParen guifg=#afffaf guibg=#3a3a3a ctermfg=157 ctermbg=237 gui=bold    cterm=bold
  hi Pmenu      guifg=#eeeeee guibg=#444444 ctermfg=255 ctermbg=238
  hi PmenuSel   guifg=#000000 guibg=#afd700 ctermfg=16  ctermbg=148
endif

" General colors
hi Cursor       guifg=NONE    guibg=#626262             ctermbg=241
hi Normal       guifg=#e4e4e4 guibg=#262626 ctermfg=254
hi NonText      guifg=#808080 guibg=#303030 ctermfg=244
hi LineNr       guifg=#808080 guibg=#080808 ctermfg=244 ctermbg=232
hi StatusLine   guifg=#3a3a3a guibg=#949494 ctermfg=237 ctermbg=246
hi StatusLineNC guifg=#3a3a3a guibg=#080808 ctermfg=237 ctermbg=232
hi VertSplit    guifg=#3a3a3a guibg=#444444 ctermfg=237 ctermbg=238
hi Folded       guifg=#5faf5f guibg=#000000 ctermfg=71  ctermbg=16
hi FoldColumn   guifg=#5faf5f guibg=#000000 ctermfg=71  ctermbg=16
hi SignColumn   guifg=#e4e4e4 guibg=#808080 ctermfg=254 ctermbg=244
hi Title        guifg=#e4e4e4 guibg=NONE    ctermfg=254             gui=bold    cterm=bold
hi Visual       guifg=#e4e4e4 guibg=#0087d7 ctermfg=254 ctermbg=32
hi SpecialKey   guifg=#808080 guibg=#303030 ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment      guifg=#808080               ctermfg=244
hi Todo         guifg=#8a8a8a               ctermfg=245
hi Boolean      guifg=#afd700               ctermfg=148
hi String       guifg=#afd700               ctermfg=148
hi Identifier   guifg=#afd700               ctermfg=148
hi Function     guifg=#eeeeee               ctermfg=255
hi Type         guifg=#8787af               ctermfg=103
hi Statement    guifg=#8787af               ctermfg=103
hi Keyword      guifg=#ff8700               ctermfg=208
hi Constant     guifg=#ff8700               ctermfg=208
hi Number       guifg=#ff8700               ctermfg=208
hi Special      guifg=#ff8700               ctermfg=208
hi PreProc      guifg=#ffffd7               ctermfg=230
hi Todo         guifg=#000000 guibg=#d7ff5f ctermfg=16  ctermbg=191 gui=italic

" Code-specific colors
hi pythonOperator guifg=#8787af gui=none ctermfg=103

" Diff
hi DiffAdd                    guibg=#303030             ctermbg=236
hi DiffDelete   guifg=#262626 guibg=NONE    ctermfg=235 ctermbg=None
hi DiffChange                 guibg=#262626             ctermbg=235
hi DiffText                   guibg=#303030             ctermbg=236

" Other Diff
hi diffRemoved  ctermfg=1
hi diffAdded    ctermfg=2
hi diffFile     ctermfg=7
hi diffLine     ctermfg=6

hi SpellBad                                 ctermbg=17
hi Directory    ctermfg=3
hi NERDTreeCWD  ctermfg=8
