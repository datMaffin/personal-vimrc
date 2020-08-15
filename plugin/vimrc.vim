inoremap jk <Esc>

" Unify defaults of Neovim and vim; Defaults are mainly from Neovim
" Mixture of Neovim defaults and tpope/sensible

if exists('g:loaded_personal_vimrc') || &compatible
    finish
else
    let g:loaded_personal_vimrc = 'yes'
endif

if has('autocmd')
    filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats=bin,hex

if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

set incsearch
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set history=10000
set wildmenu
set wildoptions=    " Always use statusline for wildmenu

set scrolloff=4     " Show a few lines of context around the cursor
set display+=lastline 
set encoding=utf-8

if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
    set shell=/usr/bin/env\ bash
endif

set autoread

set sessionoptions-=options
set viewoptions-=options

set belloff=all
set cscopeverbose
set shortmess=filnxtToOF
set showcmd
set nostartofline
set tabpagemax=50
if !empty(&viminfo)
    set viminfo^=!
endif

" Load matchit.vim
if !exists('g:loaded_matchit')
    runtime! macros/matchit.vim
endif

if empty(mapcheck('<C-U>', 'i'))
    inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
endif

if !has('nvim')
    set ttymouse=xterm2 " Compatibility with tmux
endif
set mouse=a	    " Enable mouse support (all modes)

set expandtab       " Insert space characters instead of tab
set tabstop=4       " Number of Spaces for every tab inserted
set softtabstop=4   " Delete the whole tab (of 4 spaces)
set shiftwidth=4    " Number of spaces inserted for indentation

" Using the statusline and line numbers with the default colorscheme is
" horrible
let use_minimal_ui = 0
"let use_minimal_ui = 1

if use_minimal_ui
    set ruler
else
    set statusline=
    set statusline+=%#StatusLine#
    set statusline+=\ %f       "tail of the filename
    set statusline+=\ ▒
    set statusline+=%#LineNr#
    set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
    set statusline+=%{&ff}] "file format
    set statusline+=%h      "help file flag
    set statusline+=%m      "modified flag
    set statusline+=%r      "read only flag
    set statusline+=%y      "filetype
    set statusline+=%=      "left/right separator
    set statusline+=%c,     "cursor column
    set statusline+=%l/%L   "cursor line/total lines
    set statusline+=\ %P    "percent through file

    set number              " Enable the line numbers
    set relativenumber      " Enable relative line numbers
    set cursorline          " Highlight cursor line
endif

set linebreak
set breakat=^!@*+;,./?<{[()]}>
set breakindent
let &showbreak="@   "

set colorcolumn=80,120,160

" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \	execute 'normal! g`"zvzz' |
                \ endif
augroup END
