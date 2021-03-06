" Maintainer:   Ian P. Thompson (ian@quornian.co.uk)
" Version:      1.0
" Last Change:  31 March 2013

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "colorscheme"
let s:colors = split(system("bash -lc 'theme show cool-2'"))

" Function to pull the colorscheme from the current theme when
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
            let s:guifg = get(s:colors, a:fg, "FF0000")
        endif
        if a:bg > 231
            let s:guibg = printf("%06X", 0x10101 * (10 * a:bg - 2312))
        else
            let s:guibg = get(s:colors, a:bg, "000000")
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
    call s:Hi("CursorLine", 0, 6, "none")
    call s:Hi("CursorColumn", 0, 6, "none")
    call s:Hi("ColorColumn", 0, 7, "none")
    call s:Hi("MatchParen", 1, "none", "underline,bold")
    
endif

" General colors
call s:Hi("Cursor", 7, 0, "reverse")
call s:Hi("Normal", 15, 0, "none")
call s:Hi("NonText", 7, 0, "none")
call s:Hi("LineNr", 7, 0, "none")
call s:Hi("Search", "none", "none", "underline,bold")
call s:Hi("StatusLine", 0, 7, "none")
call s:Hi("StatusLineNC", 0, 7, "none")
call s:Hi("TabLineFill", 0, 7, "none")
call s:Hi("TabLine", 0, 7, "none")
call s:Hi("WildMenu", 7, 4, "bold")
call s:Hi("TabLineSel", 7, 0, "bold")
call s:Hi("VertSplit", 7, 7, "none")
call s:Hi("Folded", 0, 7, "none")
call s:Hi("FoldColumn", 7, 0, "none")
call s:Hi("SignColumn", 6, 0, "none")
call s:Hi("Title", 6, 0, "bold")
call s:Hi("Visual", 7, 4, "bold")
call s:Hi("SpecialKey", 1, 0, "none")

call s:Hi("Directory", 4, 0, "none")
call s:Hi("Error", 1, 0, "reverse,bold")
call s:Hi("ErrorMsg", 1, 0, "reverse,bold")
call s:Hi("WarningMsg", 1, 0, "none")
call s:Hi("Question", 7, 0, "bold")

" Syntax highlighting
call s:Hi("Comment", 0, 0, "bold")
call s:Hi("Todo", 3, 0, "underline")
call s:Hi("Boolean", 7, 0, "none")
call s:Hi("String", 4, 0, "none")
call s:Hi("Number", 3, 0, "none")
call s:Hi("Special", 6, 0, "none")
"call s:Hi("Identifier", 3, 0, "none")
"call s:Hi("Function", 7, 0, "none")
"call s:Hi("Type", 5, 0, "bold")
"call s:Hi("Statement", 4, 0, "bold")
"call s:Hi("Keyword", 4, 0, "none")
"call s:Hi("Constant", 5, 0, "none")
"call s:Hi("PreProc", 4, 0, "bold")
call s:Hi("Identifier", 6, 0, "none")
call s:Hi("Function", 6, 0, "none")     " eg. _ name(...):
call s:Hi("Type", 6, 0, "bold")
call s:Hi("Statement", 2, 0, "bold")    " eg. class _: def _: if _:
call s:Hi("Operator", 2, 0, "none")     " eg. _ not in _ or _
call s:Hi("Keyword", 4, 0, "none")
call s:Hi("Constant", 4, 0, "none")
call s:Hi("PreProc", 5, 0, "bold")      " eg. from _ import _
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
"match WhitespaceError /\S\@<=\s\+$\|\t/
match WhitespaceError /\S\@<=\s\+$/

" When 256 is available, modify *some* colors but keep most consistent
" we rely instead on the terminal palette
if &term != "linux"
  set t_Co=256
  if $LIGHTBG == "1"
    call s:Hi("ColorColumn", "none", 255, "none")
    call s:Hi("VertSplit", 253, "none", "none")
    call s:Hi("StatusLine", 7, 255, "bold")
    call s:Hi("StatusLineNC", 0, 255, "bold")
    call s:Hi("TabLineFill", 7, 254, "none")
    call s:Hi("TabLine", 0, 254, "bold")
    call s:Hi("NonText", 0, 254, "none")
    
    " Diff
    call s:Hi("DiffAdd", "none", 156, "none")
    call s:Hi("DiffDelete", 240, 216, "none")
    call s:Hi("DiffChange", 240, 228, "none")
    call s:Hi("DiffText", "none", 227, "none")
    call s:Hi("Folded", 240, 255, "none")
    call s:Hi("SignifySignAdd", 2, 156, "none")
    call s:Hi("SignifySignDelete", 1, 216, "none")
    call s:Hi("SignifySignChange", 3, 228, "none")
    "SignifySignChange  SignifySignDelete
  else
    call s:Hi("ColorColumn", "none", 233, "none")
    call s:Hi("VertSplit", 234, "none", "none")
    call s:Hi("StatusLine", 7, 234, "bold")
    call s:Hi("StatusLineNC", 0, 234, "bold")
    call s:Hi("TabLineFill", 7, 234, "none")
    call s:Hi("TabLine", 0, 234, "bold")
    call s:Hi("NonText", 0, 234, "none")
    
    " Diff
    call s:Hi("DiffAdd", "none", 236, "none")
    call s:Hi("DiffDelete", 233, 233, "none")
    call s:Hi("DiffChange", 245, 235, "none")
    call s:Hi("DiffText", "none", 234, "none")
    call s:Hi("Folded", 240, 232, "none")
    call s:Hi("SignifySignAdd", 2, 234, "none")
    call s:Hi("SignifySignDelete", 1, 234, "none")
    call s:Hi("SignifySignChange", 3, 234, "none")
    "SignifySignChange  SignifySignDelete
  endif
endif
