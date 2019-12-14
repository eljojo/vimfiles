"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off " required for Vundle

" setup plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/delimitMate.vim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-bundler'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
" Plug 'mustache/vim-mustache-handlebars'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
" Plug 'derekwyatt/vim-scala'
Plug 'ngmy/vim-rubocop'
Plug 'eapache/rainbow_parentheses.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'janko-m/vim-test'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set number      "show line numbers

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set ignorecase!  " Ignore case in search

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

" using bash as shell so the PATH is set correctly
set shell=/bin/bash

" remap leader to ,
let mapleader = ","

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent

set title                " change the terminal's title

"turn on syntax highlighting
syntax on

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" split windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W :split<CR><C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

" red column at 80 characters
set colorcolumn=80

set wildignore+=tmp,storage

set encoding=utf-8
set ttyfast

set backupdir=~/.vim/backup
set directory=~/.vim/backup

" load NERDTree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" fixes editing the crontab
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Run Rubocop with Leader+r
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

" Enable RainbowParentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Enable CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<Leader>')

" load JSX in .js files
let g:jsx_ext_required = 0

" ignore node_modules with ctrl+p
set wildignore+=*/node_modules/*,*/deps/*

" bind fzf to ctrl+p
map <C-p> :Files<CR>

" gotta go fast
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" vim-test: https://github.com/janko-m/vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" https://www.boost.co.nz/blog/2018/01/improving-ruby-rails-debugging-ctags
command! MakeTags !ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
