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
  hi CursorLine               guibg=#2d2d2d             ctermbg=236            
  hi CursorColumn             guibg=#2d2d2d             ctermbg=236            
  hi ColorColumn              guibg=gray7               ctermbg=233            
  hi MatchParen guifg=#d0ffc0 guibg=#2f2f2f ctermfg=157 ctermbg=237 gui=bold    cterm=bold
  hi Pmenu      guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238            
  hi PmenuSel   guifg=#000000 guibg=#b1d631 ctermfg=0   ctermbg=148            
endif                                                                          
                                                                               
" General colors                                                               
hi Cursor       guifg=NONE    guibg=#626262             ctermbg=241
hi Normal       guifg=#e2e2e5 guibg=#202020 ctermfg=253            
hi NonText      guifg=#808080 guibg=#303030 ctermfg=244            
hi LineNr       guifg=#808080 guibg=#000000 ctermfg=244 ctermbg=232
hi StatusLine   guifg=#d3d3d5 guibg=#444444 ctermfg=237 ctermbg=246
hi StatusLineNC guifg=#939395 guibg=#444444 ctermfg=237 ctermbg=232 
hi VertSplit    guifg=#444444 guibg=#444444 ctermfg=237 ctermbg=238
hi Folded       guifg=#a0a8b0 guibg=#444444 ctermfg=2   ctermbg=16 
hi FoldColumn   guifg=#a0a8b0 guibg=#444444 ctermfg=2   ctermbg=16 
hi SignColumn   guifg=Cyan    guibg=Grey    ctermfg=14  ctermbg=none
hi Title        guifg=#f6f3e8 guibg=NONE    ctermfg=254             gui=bold    cterm=bold
hi Visual       guifg=#faf4c6 guibg=#3c414c ctermfg=254 ctermbg=4  
hi SpecialKey   guifg=#808080 guibg=#343434 ctermfg=244 ctermbg=236
                                                                               
" Syntax highlighting                                                          
hi Comment      guifg=#808080               ctermfg=244             gui=italic 
hi Todo         guifg=#8f8f8f               ctermfg=245             gui=italic 
hi Boolean      guifg=#b1d631               ctermfg=148           
hi String       guifg=#b1d631               ctermfg=148             gui=italic 
hi Identifier   guifg=#b1d631               ctermfg=148          
hi Function     guifg=#ffffff               ctermfg=255             gui=bold   
hi Type         guifg=#7e8aa2               ctermfg=103         
hi Statement    guifg=#7e8aa2               ctermfg=103         
hi Keyword      guifg=#ff9800               ctermfg=208         
hi Constant     guifg=#ff9800               ctermfg=208         
hi Number       guifg=#ff9800               ctermfg=208         
hi Special      guifg=#ff9800               ctermfg=208         
hi PreProc      guifg=#faf4c6               ctermfg=230         
hi Todo         guifg=#000000 guibg=#e6ea50                         gui=italic

" Code-specific colors
hi pythonOperator guifg=#7e8aa2 gui=none ctermfg=103

" Diff
hi DiffAdd      ctermbg=236
hi DiffDelete   ctermbg=None  ctermfg=235
hi DiffChange   ctermbg=235
hi DiffText     ctermbg=236

hi SpellBad                                 ctermbg=17
