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

let colors_name = "dave_on_light"

hi Normal       guifg=black         guibg=white     gui=none        ctermfg=black        ctermbg=white      cterm=none
hi comment      guifg=darkgray                      gui=none        ctermfg=gray
hi constant     guifg=blue                          gui=bold        ctermfg=darkblue                        cterm=bold
hi identifier   guifg=gray                                          ctermfg=gray
hi keyword      guifg=darkred                                       ctermfg=darkred
hi statement    guifg=darkred                       gui=bold        ctermfg=darkred                         cterm=bold
hi string       guifg=red                                           ctermfg=red
hi special      guifg=red                                           ctermfg=red
hi type         guifg=red                                           ctermfg=red


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
