inoremap jk <Esc>

" set leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Ctrl-Backspace as delete word
"noremap! <C-BS> <C-w>
"noremap! <C-h> <C-w>

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
set smarttab

set complete-=i
set completeopt+=menuone,noselect

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
"set wildoptions=    " Always use statusline for wildmenu

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

" Load optional (but normally included) packages
" If this file is used as vimrc it may be sensible to change "packadd" to "packadd!"
packadd matchit
packadd termdebug

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
if $TERM == 'alacritty' | set ttymouse=sgr | endif

set expandtab       " Insert space characters instead of tab
set tabstop=4       " Number of Spaces for every tab inserted
set softtabstop=4   " Delete the whole tab (of 4 spaces)
set shiftwidth=4    " Number of spaces inserted for indentation

" Using the statusline and line numbers with the default colorscheme is
" horrible
if exists('g:use_detailed_ui') && g:use_detailed_ui
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
    " relative numbers are seldomly useful for me and are REALLY confusing when screen sharing.
    "set relativenumber      " Enable relative line numbers
    set cursorline          " Highlight cursor line
else
    set ruler
endif

set linebreak
set breakat=^!@*+;,./?<{[()]}>
set breakindent
let &showbreak="@   "

function! TextPrefFunction()
   " Set breakat to default and shorten showbreak
   set breakat=\ ^I!@*-+;:,./?
   let &showbreak="@"
endfunction

autocmd Filetype tex call TextPrefFunction()

set colorcolumn=80,100,132

" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \	execute 'normal! g`"zvzz' |
                \ endif
augroup END

" make clipboard work on wayland systems
" copied from https://github.com/jasonccox/vim-wayland-clipboard/blob/master/plugin/wayland_clipboard.vim
" The MIT License (MIT)
"
" Copyright (c) 2021 Jason Cox
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.
if !has('nvim') && !empty($WAYLAND_DISPLAY) && executable('wl-copy') && executable('wl-paste')

    " cannot use the + register when the clipboard feature is disabled
    if !has('clipboard')
        nnoremap "+ "v
        vnoremap "+ "v
    endif

    " pass register contents to wl-copy if the '+' (or 'v') register was used
    function! s:WaylandYank()
        if v:event['regname'] == '+' || (v:event['regname'] == 'v' && !has('clipboard'))
            silent call system('wl-copy', getreg(v:event['regname']))
        endif
    endfunction

    " run s:WaylandYank() after every time text is yanked
    augroup waylandyank
        autocmd!
        autocmd TextYankPost * call s:WaylandYank()
    augroup END
    
    
    let prepaste = "let @\"=substitute(system('wl-paste --no-newline'), \"\\r\", '', 'g')"

    for p in ['p', 'P']
        execute "nnoremap \"+" . p . " :<C-U>" . prepaste . " \\| exec 'normal! ' . v:count1 . '" . p . "'<CR>"
    endfor

    for cr in ['<C-R>', '<C-R><C-R>', '<C-R><C-O>', '<C-R><C-P>']
        execute "inoremap " . cr . "+ <C-O>:<C-U>" . prepaste . "<CR>" . cr . "\""
    endfor

endif


" GVim settings
set guioptions-=T  "remove toolbar
