imap jk <Esc>

set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set ttymouse=xterm2 " Compatibility with tmux
set mouse=a	    " Enable mouse support (all modes)
set scrolloff=4     " Show a few lines of context around the cursor
set autoindent      " see :h
set smartindent     " see :h
set expandtab       " Insert space characters instead of tab
set tabstop=2       " Number of Spaces for every tab inserted
set softtabstop=2   " Delete the whole tab (of 2 spaces)
set shiftwidth=2    " Number of spaces inserted for indentation

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

set showbreak=@

set colorcolumn=80,120,160

set foldcolumn=1        " Set number of columns used for showing folding

set hlsearch    " enables highlighting of the last pattern search

" Return to the same line you left off at
augroup line_return
	au!
	au BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\	execute 'normal! g`"zvzz' |
		\ endif
augroup END

" greater default size when in gvim
if has('gui_running')
    set lines=40 columns=95
endif
