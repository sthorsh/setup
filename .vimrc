"--------------------------------------
" Vi compatibility
"--------------------------------------
set nocompatible

"--------------------------------------
" Plugins
"--------------------------------------
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'anshin/vim-wombat256'
    Plugin 'kien/ctrlp.vim'
    Plugin 'fholgado/minibufexpl.vim'
    Plugin 'sjl/gundo.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'
    Plugin 'nelstrom/vim-qargs'
    Plugin 'lokaltog/vim-easymotion'
    Plugin 'tommcdo/vim-exchange'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'godlygeek/tabular'
    Plugin 'vim-scripts/vis'
    Plugin 'shinokada/dragvisuals.vim'
    Plugin 'nelstrom/vim-visual-star-search'
    Plugin 'raimondi/delimitMate'               "insert mode
    Plugin 'tomtom/tlib_vim'                    "snipmate
    Plugin 'MarcWeber/vim-addon-mw-utils'       "snipmate
    Plugin 'honza/vim-snippets'                 "snipmate
    Plugin 'garbas/vim-snipmate'                "snipmate
    " Plugin 'tpope/vim-fugitive'
    " Plugin 'Valloric/YouCompleteMe'
  call vundle#end()

"--------------------------------------
" Filetype detection
"--------------------------------------
filetype plugin indent on

"--------------------------------------
" Syntax highlighting
"--------------------------------------
syntax on
colorscheme wombat256
hi clear ModeMsg
hi clear SpellBad
hi clear StatusLine
hi ModeMsg ctermfg=110
hi SpecialKey ctermfg=197 "tab, nbsp , trail
hi SpellBad ctermfg=1
hi StatusLine ctermfg=230 ctermbg=238

" Highlight 81st column (Damian Conway plugin)
hi ColorColumn ctermbg=red
call matchadd ('ColorColumn', '\%161v',100)

" MBE plugin
hi MBEVisibleActiveNormal ctermfg=230 ctermbg=238
hi MBEVisibleActiveChanged ctermfg=196 ctermbg=238
hi MBEVisibleNormal ctermfg=153 cterm=underline
hi MBEVisibleChanged ctermfg=196 cterm=underline
hi MBEChanged ctermfg=196

"--------------------------------------
"  Variables
"--------------------------------------
let mapleader=","
let g:ctrlp_extensions = ['tag', 'line']
let g:delimitMate_expand_space = 1
let g:miniBufExplBRSplit = 0
let g:miniBufExplStatusLineText="MBE"
let g:miniBufExplVSplit = 20

"--------------------------------------
"  Options
"--------------------------------------
" Boolean
set expandtab
set hlsearch
set incsearch
set noswapfile
set notimeout
set number
set showcmd
set splitright splitbelow
set wildmenu

" Numbers
set backspace=2
set history=500
set laststatus=2
set shiftwidth=2
set softtabstop=2
set textwidth=160

" Strings
set cpoptions+=$
set dictionary+=/usr/share/dict/words
set grepprg=internal
set listchars=tab:»»,nbsp:·,trail:.,eol:$
set pastetoggle=<F2>
set statusline=%t%r[%l][%c%V]
set virtualedit=all
set wildmode=longest:full,full

"--------------------------------------
"  Maps
"--------------------------------------
nnoremap & :&&<CR>
nnoremap Q @='n.'<CR>
nnoremap Y y$
nnoremap <Space> :nohlsearch<CR>
nnoremap <C-s> :update<CR>
nnoremap <C-w>se <C-w>^
nnoremap <C-w>ve <C-w>^<C-w>L
nnoremap <C-w>sn :new<CR>
nnoremap <C-w>vn :vert new<CR>
nnoremap <leader>G :GundoToggle<CR>
nnoremap <leader>M :MBEToggle<CR>
nnoremap <leader>N :NERDTreeToggle<CR>
nnoremap <leader>T :TagbarToggle<CR>
nnoremap <leader>c :%s/\s\+$//e<CR>
nnoremap <leader>t :Tab /\v^[^,]*\zs,/l1c0l1<CR><Space>

vnoremap & :&&<CR>
vnoremap <leader>a :s/\%V\s*//<CR><C-l><C-o>
vmap <expr> <up> DVB_Drag('up')
vmap <expr> <down> DVB_Drag('down')
vmap <expr> <left> DVB_Drag('left')
vmap <expr> <right> DVB_Drag('right')

inoremap b <Esc>Bi
inoremap f <Esc>ef i
inoremap d <C-O>de
inoremap <C-c> <Nop>
inoremap <C-d> <C-o>x
inoremap <C-s> <C-o>:update<CR><Esc>l
  
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Practical Vim 41
cnoremap <expr> %% getcmdtype() == ':' ? expand ('%:h').'/' : '%%'

"--------------------------------------
"  Autocommands
"--------------------------------------
if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1
  " autocmd BufWritePost * call system("ctags -R")
  " autocmd BufWritePost * call system("cscope -RUbq")
  autocmd BufWritePost * :silent cs reset
endif

