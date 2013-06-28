" Maintainer:   Ian P. Thompson (ian@quornian.co.uk)
" Version:      1.0
" Last Change:  31 March 2013

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "colorscheme"

" Function to pull the colorscheme from environment variables $__c? when
" opening the gvim GUI
function! s:Hi(type, fg, bg, flags)
    if has("gui_running")
        let s:fg = a:fg
        if s:fg > 231
            let s:guifg = printf("%06X", 0x10101 * (10 * s:fg - 2312))
        else
            if match(a:flags, "bold") != -1
                let s:fg += 8
            endif
            exe "let s:guifg=$__c" . printf("%X", s:fg)
        endif
        if a:bg > 231
            let s:guibg = printf("%06X", 0x10101 * (10 * a:bg - 2312))
        else
            exe "let s:guibg=$__c" . printf("%X", a:bg)
        endif
        exe "highlight " . a:type .
            \ " guifg=#" . s:guifg . " guibg=#" . s:guibg . " gui=" . a:flags
    else
        let s:bg = a:bg
        if s:bg == 0
            let s:bg = "none"
        endif
        exe "highlight " . a:type .
            \ " ctermfg=" . a:fg . " ctermbg=" . s:bg . " cterm=" . a:flags
    endif
endfunction

" Vim >= 7.0 specific colors
if version >= 700
    call s:Hi("CursorLine", 0, 0, "reverse")
    call s:Hi("CursorColumn", 0, 0, "reverse")
    call s:Hi("ColorColumn", 0, 7, "none")
    call s:Hi("MatchParen", 1, "none", "underline,bold")
    
    call s:Hi("Pmenu", 0, 7, "none")
    call s:Hi("PmenuSel", 0, 2, "none")
endif

" General colors
call s:Hi("Cursor", 7, 0, "reverse")
call s:Hi("Normal", 7, 0, "none")
call s:Hi("NonText", 7, 0, "none")
call s:Hi("LineNr", 7, 0, "none")
call s:Hi("Search", 3, 0, "underline,bold")
call s:Hi("StatusLine", 0, 7, "none")
call s:Hi("StatusLineNC", 0, 7, "none")
call s:Hi("TabLineFill", 0, 7, "none")
call s:Hi("TabLine", 0, 7, "none")
call s:Hi("TabLineSel", 7, 0, "bold")
call s:Hi("VertSplit", 7, 7, "none")
call s:Hi("Folded", 0, 7, "none")
call s:Hi("FoldColumn", 7, 0, "none")
call s:Hi("SignColumn", 6, 0, "none")
call s:Hi("Title", 6, 0, "bold")
call s:Hi("Visual", 7, 4, "bold")
call s:Hi("SpecialKey", 1, 7, "bold")

call s:Hi("Directory", 4, 0, "none")
call s:Hi("Error", 1, 7, "reverse,bold")
call s:Hi("WarningMsg", 1, 0, "none")
call s:Hi("Question", 7, 0, "bold")

" Syntax highlighting
call s:Hi("Comment", 0, 0, "bold")
call s:Hi("Todo", 0, 2, "none")
call s:Hi("Boolean", 7, 0, "none")
call s:Hi("String", 2, 0, "none")
call s:Hi("Number", 4, 0, "none")
call s:Hi("Special", 6, 0, "none")
call s:Hi("Identifier", 6, 0, "none")
call s:Hi("Function", 7, 0, "none")
call s:Hi("Type", 6, 0, "bold")
call s:Hi("Statement", 4, 0, "bold")
call s:Hi("Keyword", 4, 0, "none")
call s:Hi("Constant", 4, 0, "none")
call s:Hi("PreProc", 4, 0, "bold")
call s:Hi("SpellBad", 0, 7, "none")

" Diff
call s:Hi("DiffAdd", 0, 2, "none")
call s:Hi("DiffDelete", 0, 1, "none")
call s:Hi("DiffChange", 0, 3, "none")
call s:Hi("DiffText", 0, 7, "none")

" Git
call s:Hi("diffAdded", 2, 0, "none")
call s:Hi("diffRemoved", 1, 0, "none")
call s:Hi("diffFile", 0, 0, "bold")
call s:Hi("diffSubname", 0, 0, "bold")
call s:Hi("gitcommitDiff", 0, 0, "bold")
call s:Hi("gitcommitBranch", 3, 0, "none")
call s:Hi("gitcommitFile", 4, 0, "none")
call s:Hi("gitcommitType", 0, 0, "bold")
call s:Hi("gitcommitOverflow", 6, 0, "none")
call s:Hi("gitcommitSummary", 7, 0, "none")

" Language specifics
call s:Hi("vimCommentTitle", 0, 0, "bold")

" Highlight trailing whitespace on non-blank lines
call s:Hi("WhitespaceError", 1, 0, "underline,bold")
match WhitespaceError /\S\@<=\s\+$\|\t/

" When 256 is available, modify *some* colors but keep most consistent
" we rely instead on the terminal palette
if &term != "linux"
  set t_Co=256
  call s:Hi("CursorLine", 0, 234, "none")
  call s:Hi("CursorColumn", 0, 234, "none")
  call s:Hi("ColorColumn", "none", 234, "none")
  call s:Hi("VertSplit", 234, 234, "none")
  call s:Hi("StatusLine", 7, 234, "bold")
  call s:Hi("StatusLineNC", 0, 234, "bold")
  call s:Hi("TabLineFill", 7, 234, "none")
  call s:Hi("TabLine", 0, 234, "bold")
  
  " Diff
  call s:Hi("DiffAdd", "none", 234, "none")
  call s:Hi("DiffDelete", 233, 0, "none")
  call s:Hi("DiffChange", "none", 233, "none")
  call s:Hi("DiffText", "none", 234, "none")
  call s:Hi("Folded", 240, 232, "none")
endif
