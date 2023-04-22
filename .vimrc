"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
" set up pathogen, https://github.com/tpope/vim-pathogen
filetype off
execute pathogen#infect()
filetype plugin indent on

" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax enable

set autoindent
set backspace=indent,eol,start
set backupdir=/tmp
"set bufhidden=delete
set bufhidden=hide
set clipboard=unnamed
set cmdheight=1
"set columns=120
set cursorline
set diffexpr=MyDiff()
set diffopt=iwhite
"set directory=/tmp
set directory-=.                           " don't store swapfiles in the current directory
set expandtab
set nofoldenable        " disable folding
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " 10 nested fold max
set formatoptions+=tcoqnl1j
" Better indention/ hierarchy
let &showbreak = '└ '
set formatlistpat=^\\s*                    " Optional leading whitespace
set formatlistpat+=[                       " Start class
set formatlistpat+=\\[({]\\?               " |  Optionally match opening punctuation
set formatlistpat+=\\(                     " |  Start group
set formatlistpat+=[0-9]\\+                " |  |  A number
set formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+ " |  |  Roman numerals
set formatlistpat+=\\\|[a-zA-Z]            " |  |  A single letter
set formatlistpat+=\\)                     " |  End group
set formatlistpat+=[\\]:.)}                " |  Closing punctuation
set formatlistpat+=]                       " End class
set formatlistpat+=\\s\\+                  " One or more spaces
set formatlistpat+=\\\|^\\s*[-–+o*•]\\s\\+ " Or bullet points
set grepprg=rg\ -i\ --color\ never\ --no-heading\ '$*'\ *\ /dev/null
set grepformat=%f:%l:%m
"set guifont=Monaco:h9
set guifont=Consolas:h12
"set guioptions=begmrLtT
set guioptions=begmrLt
set hidden
set hlsearch
set ignorecase
set incsearch
set joinspaces
set laststatus=2
set lazyredraw
set linebreak
"set lines=60
set list                                                     " show trailing whitespace
"set listchars=tab:▸\ ,trail:▫
set listchars=tab:»·,trail:¶
set magic
set matchtime=2
set more
set noautowrite
set nobackup
set nocompatible
set noerrorbells
set nowrap
set nowritebackup
set number
set report=0
set ruler
set runtimepath^=~/.vim/bundle/ag.vim
set rtp+=/opt/homebrew/opt/fzf
set scrolloff=3
set selectmode=
"set shell=tcsh\ -f
set shiftround
set shiftwidth=4
set shortmess+=I
set showcmd
set showmatch
set showmode
set smartindent
set smarttab
set statusline=%<%f%h%m%r\ [%{&ff}]%=\ %l,%c%V\ %P
"set statusline=%<%f\ %h%m%r\ [%{&ff}]%=[%{Tlist_Get_Tagname_By_Line()}]\ \ %-14.(%l,%c%V%)\ %P
set t_vb=
set tabstop=4
set tags=tags;/
set term=ansi
set title
"set ttyfast
set undolevels=200
set viminfo=%,'50,\"100,:100,n~/.viminfo
set visualbell
set whichwrap=b,s,h,l,<,>,[,]
set wildchar=<TAB>
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full


" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

if has('gui_running')
    set background=light
else
    set background=dark
endif

"colorscheme dave
colorscheme pyte
"colorscheme solarized

"From http://use.perl.org/~hanekomu/journal/34741
nmap <C-v><C-n> :cnext<CR>
imap <C-v><C-n> <Esc><C-v><C-n>
nmap <C-v><C-p> :cprev<CR>
imap <C-v><C-p> <Esc><C-v><C-p>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <leader>cd :cd 
nmap <leader>A :Ack 
nmap <leader>b :CommandTBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CommandT<CR>
nmap <leader>T :CommandTFlush<CR>:CommandT<CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :ToggleGitGutter<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

nnoremap <Leader>w :set wrap<CR>
nnoremap <Leader>W :set nowrap<CR>

nmap <Leader>qq :q!<CR>
nmap <Leader>n :bn<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bp :bp<CR>

nmap <Leader>a :A<CR>

nmap <Leader>= gg=G
nmap <Leader>s :%!sort<CR>
nmap <Leader>su :%!sort -u<CR>
nmap <Leader>fx :%!xmllint --noblanks --format -<CR>:set filetype=xml<CR>gg=G
nmap <Leader>ff :%s/^\s*//g<CR>:%j!<CR>:%!xmllint --noblanks --format -<CR>:set filetype=xml<CR>

nmap <Leader>' :%s#^.\+$#'&'#g<CR>
nmap <Leader>, :g/^\s*$/d<CR>:%s#$#,#g<CR>:%j<CR>:%s#\(,\s*\)*$##g<CR>
nmap <Leader>,, :%s#,\s*#\r#g<CR>
nmap <Leader>$ mz<CR>:%s#\s*$##g<CR>/asdf<CR>'z

imap <C-j> <ESC>:j!<CR>
cmap <C-j> <ESC>:j!<CR>
nmap <C-j> <ESC>:j!<CR>

" From http://dougblack.io/words/a-good-vimrc.html
" Also https://news.ycombinator.com/item?id=10364760
" space open/closes folds
nnoremap <space> za

" open ag.vim
nnoremap <leader>a :Ag

" https://github.com/tacahiroy/ctrlp-funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

map <Tab> >0
map <S-Tab> <0
imap <S-Tab> <Esc> < i

map ;; :%s###g<Left><Left><Left>
map ;' :%s###gc<Left><Left><Left><Left>
cmap ;\ \(\)<Left><Left>

vmap <Leader>fx !xmllint --format -<CR>
nmap <Leader>fx :%!xmllint --format -<CR>

map <silent> <Leader>l :call BufferList()<CR>


function MyDiff()
    let opt = ""
    if &diffopt =~ "icase"
        let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
        let opt = opt . "-b "
    endif
    silent execute '!"/usr/bin/diff" -a --binary ' . opt . " " . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction

" Courtesy of Michael Naumann, J?rgen Kr?mer
" Visually select text, then search for it, forwards or backwards
vmap <silent> * :<C-U>let old_reg=@"<cr>
                  \gvy/<C-R><C-R>=substitute(
                  \escape(@", '\\/.*$^~[]'), "\n$", "", "")<CR><CR>
                  \:let @"=old_reg<cr>

vmap <silent> # :<C-U>let old_reg=@"<cr>
                  \gvy?<C-R><C-R>=substitute(
                  \escape(@", '\\/.*$^~[]'), "\n$", "", "")<CR><CR>
                  \:let @"=old_reg<cr>

nnoremap <F3> :NumbersToggle<CR>


" From http://items.sjbach.com/319/configuring-vim-right
" Also http://weblog.jamisbuck.org/2008/11/17/vim-follow-up
"runtime macros/matchit.vim


"MacVim
let macvim_hig_shift_movement = 1
map <C-F> <PageDown>

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplModSelTarget = 1

let g:neocomplcache_enable_at_startup = 1

" plugin settings
let g:CommandTMaxHeight=20
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0
" ZOMG the_silver_searcher is so much faster than ack"
let g:ackprg = 'ag --nogroup --column'



" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" don't expand tabs in makefiles
autocmd FileType make     set noexpandtab
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif

let g:syntastic_mode_map = {
\ 'mode': 'active',
\ 'passive_filetypes': ['javac']
\ }

