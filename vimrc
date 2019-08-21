set viminfo=

set expandtab
set tabstop=3
set shiftwidth=3
set encoding=utf-8

set foldlevel=999
set textwidth=0
set noequalalways
set noerrorbells
set visualbell
set showmatch
set noignorecase
set ruler
set nowrap
set nowrapscan
set formatprg=wrap
set updatecount=0
set nocompatible
set backspace=indent,eol,start

set foldmethod=manual
set nofoldenable
set foldnestmax=5

nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>
nmap <F4> :!pil test.l +<CR>
imap <F4> <c-o><F2><c-o><F4>
au BufRead,BufNewFile *.l set filetype=lisp
