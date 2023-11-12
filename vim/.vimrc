let g:mips_dependency_path='/home/f23s12/Soup-To-Nuts-Assembly/vim'
set runtimepath+=~/.vim/

source /home/f23s12/Soup-To-Nuts-Assembly/vim/mips.vim

"VIM doesn't know .s files so we have to tell VIM on these file-types to"
"treat the syntax differently. Otherwise, the syntax"
"will be considered as off by default"
"
autocmd BufNewFile,BufRead *.s set filetype=mips
autocmd FileType mips set syntax=mips

syntax enable
"Enable filetype detection, plugins, and indentation"
filetype plugin indent on

"Set tabstop, shiftwidth, and expandtab"
set tabstop=4
set shiftwidth=4
set expandtab

"Display line numbers"
set number

"Highlight search results as you type"
set incsearch

"Highlight matching parentheses"
set showmatch

" Enable line wrapping"
set wrap

"Enable line numbers for wrapped lines"
set linebreak
set nolist

"Show line and column number in the status line"
set ruler

"Enable automatic indentation"
"set autoindent"
"set smartindent"
"set cindent"

"Highlight current line"
set cursorline

"Enable mouse supports (if terminal supports it)"
set mouse=a

"Set the color scheme"
"colorscheme desert"

