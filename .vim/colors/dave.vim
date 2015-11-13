" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

let colors_name = "dave"

hi Normal       guifg=black         guibg=white     gui=none        ctermfg=white        ctermbg=none       cterm=none
hi comment      guifg=darkgray                      gui=none        ctermfg=gray                            gui=none
hi constant     guifg=blue                          gui=bold        ctermfg=darkblue                        cterm=bold
hi identifier   guifg=gray                                          ctermfg=gray
hi keyword      guifg=darkred                                       ctermfg=darkred
hi statement    guifg=darkred                       gui=bold        ctermfg=darkred                         cterm=bold
hi string       guifg=red                                           ctermfg=red
hi special      guifg=red                                           ctermfg=red
hi type         guifg=red                                           ctermfg=red
hi LineNr		guifg=darkgray                      gui=bold		ctermfg=black                           cterm=bold


"    Black
"    DarkBlue
"    DarkGreen
"    DarkCyan
"    DarkRed
"    DarkMagenta
"    Brown, DarkYellow
"    LightGray, LightGrey, Gray, Grey
"    DarkGray, DarkGrey
"    Blue, LightBlue
"    Green, LightGreen
"    Cyan, LightCyan
"    Red, LightRed
"    Magenta, LightMagenta
"    Yellow, LightYellow
"    White
