inoremap jk <Esc>

" Unify defaults of Neovim and vim; Defaults are mainly from Neovim
" Mixture of Neovim defaults and tpope/sensible

set autoindent
set autoread
set backspace=indent,eol,start
set belloff=all
set complete-=i
set cscopeverbose
set display+=lastline " vim does not seam to have "msgsep" as an option
set encoding=utf-8
set formatoptions=tcqj
set history=10000
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:> ,trail:-,nbsp:+
set nrformats=bin,hex
"set ruler  " I use the statusline instead of the ruler
set sessionoptions-=options
set shortmess=filnxtToOF
set showcmd
set sidescroll=1
set smarttab
set nostartofline
set tabpagemax=50
set ttimeoutlen=100 " nvim uses 50
if !empty(&viminfo)
  set viminfo^=!
endif
set wildmenu
set wildoptions=''  " Use Vim default here: I like how wild uses the statusline

" Additional settings found in tpope/sensible not part of Neovim defaults
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set ttymouse=xterm2 " Compatibility with tmux
set mouse=a	    " Enable mouse support (all modes)
set scrolloff=4     " Show a few lines of context around the cursor
set sidescrolloff=5 " Show a few columns of context around the cursor
set smartindent     " see :h
set expandtab       " Insert space characters instead of tab
set tabstop=2       " Number of Spaces for every tab inserted
set softtabstop=2   " Delete the whole tab (of 4 spaces)
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

set linebreak
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
