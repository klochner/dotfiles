"set binary
"set noeol

let mapleader = ","
filetype on
set nocompatible
compiler ruby
execute pathogen#infect()

"show/hide trailing whitespace
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd BufWritePre * :%s/\s\+$//e "removes all trailing whitespace upon :w
:nnoremap <Leader>sw :match ExtraWhitespace /\s\+$/<CR>
:nnoremap <Leader>hw :match<CR>


"fonts/colors
set linespace=2
syntax on
colorscheme vividchalk
set anti " antialiasing on
set gfn=Inconsolata:h11

"slim =~ haml
au BufNewFile,BufRead *.slim set filetype=haml

"line numbering
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=Black
set number

"reload vimrc
"imap <leader>V :source ~/.vimrc

"macvim specific
if has("gui_macvim")
  "auto reload CommandT
  autocmd FocusGained * if exists(":CommandTFlush") | call s:CmdTFlush() | endif
  autocmd BufWritePost * if exists(":CommandTFlush") | call s:CmdTFlush() | endif
endif

function s:CmdTFlush(...)
  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

"code indentation
set autoindent
set smartindent
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2

vmap <leader>t :Tabularize /=<CR>
if has("autocmd")
  filetype indent on
endif


"alias nerdtree
nmap <leader>d :NERDTreeToggle<CR>
imap ;; <C-P>


"navigate code blocks
:nmap [[ ?def <CR>
:nmap ]] /def <CR>

:nmap <leader>gip :grep -InR

"easier most-recently-used access
:nmap <leader>mr :MRU<CR>

"split window vertically
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l

set path=/Users/klochner/projects/RMO/website-rest/**
set path+=/Users/klochner/projects/RMO/website-rest/app/models/campaigns/**

"vim
set laststatus=2
set statusline=%{GitBranch()}
