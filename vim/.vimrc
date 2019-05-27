" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.

 Plug 'lervag/vimtex'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" use XeLaTeX engine
let g:vimtex_latexmk_options="-pdf -pdflatex='xelatex -file-line-error -shell-escape -synctex=1'"

" below are adopted from https://zhuanlan.zhihu.com/p/60049290
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_recursive_bib=0
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'
set conceallevel=1
let g:tex_conceal='abdmg'

" no compatible with vi
set nocompatible

filetype plugin indent on

" spell check
setlocal spell spelllang=en

" auto complete
set complete+=kspell

" encoding
set encoding=utf-8

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
"set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1 

" highlight search
set hlsearch 

" change the comment color to lightblue
highlight comment ctermfg=lightblue

" insert <space> in the normal mode
nnoremap ss i<space><esc>

" resolve the problem of copy-paste adding 0~ and 1~ problem
set t_BE=

" let paste without indentation
set paste
