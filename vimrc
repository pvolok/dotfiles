" vim: fdm=marker

" Settings {{{
""""""""""""""

set nocompatible

" General
set number relativenumber " Show relative line numbers
set linebreak " Break lines at word (requires Wrap lines)
set showbreak=+++ " Wrap-broken line prefix
set textwidth=100 " Line wrap (number of cols)
set showmatch " Highlight matching brace
set visualbell " Use visual bell (no beeping)

set hlsearch " Highlight all search results
set ignorecase " Needed for smartcase
set smartcase " Enable smart-case search
set infercase " Case insensitive autocompletion
set incsearch " Searches for strings incrementally

set autoindent " Auto-indent new lines
set expandtab " Use spaces instead of tabs
set shiftwidth=2 " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab
set textwidth=80

syntax on

set laststatus=2 " Always show status line

" Wildmenu
set wildmenu
set wildmode=longest,list

" Omni completion
set completeopt+=longest

"" Advanced
set ruler " Show row and column ruler information

set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start " Backspace behaviour
set colorcolumn=80
set cursorline " Highlight current line

" }}}

" Plugins {{{
"""""""""""""

" Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-unimpaired'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'flazz/vim-colorschemes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

"Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'

Plug 'vim-airline/vim-airline'
Plug 'groenewege/vim-less'
Plug 'evidens/vim-twig'
Plug 'gabrielelana/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
"Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'

Plug 'altercation/vim-colors-solarized'
Plug 'jpo/vim-railscasts-theme'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'jnurmine/Zenburn'
Plug 'tomasr/molokai'
Plug 'sjl/badwolf'
Plug 'chriskempson/base16-vim'
Plug 'jordwalke/flatlandia'

Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'

Plug 'wincent/terminus'

" Code assist
Plug 'flowtype/vim-flow', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'octol/vim-cpp-enhanced-highlight'

" Required:
call plug#end()

" Required:
filetype plugin indent on

" }}}

" Color scheme {{{

set background=dark
if has("gui_running")
  colorscheme base16-tomorrow-night
  set guifont=Source\ Code\ Pro\ Light:h14"
  set guioptions+=c " Disable gui dialogs
  set guioptions-=e " Disable gui tabs
else
  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif
endif

" }}}

" NERDTree {{{
let NERDTreeIgnore=['^\.DS_Store$', '^\.git$', '\~$']
let NERDTreeShowHidden=1
" Would be useful mappings, but they interfe with my default window movement
" bindings (<C-j> and <C-k>).
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'
" Close vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" BufExplorer
let g:bufExplorerDefaultHelp=0

" Neoformat {{{
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_cpp = ['clangformat']
" }}}

" Syntastic {{{
"let g:syntastic_error_symbol = "\u2717"
"let g:syntastic_warning_symbol = "!"
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 " don't check before quitting

let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_javascript_checkers = ['flow']
let g:syntastic_javascript_flow_exe = 'flow'
" }}}

" ale {{{
let g:ale_linters = {
\   'javascript': ['flow', 'eslint'],
\   'ocaml': ['merlin'],
\ }
" }}}

" AirLine {{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
" }}}

"" ack-vim
let g:ackprg = 'ag --nogroup --nocolor --column'

"" vim-javascript
let g:javascript_plugin_flow = 1

" vim-lsp {{{
if executable('clangd')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd']},
    \ 'whitelist': ['c', 'cpp'],
    \ })
endif
autocmd FileType cpp setlocal omnifunc=lsp#complete
" }}}

"" vim-jsx
let g:jsx_ext_required=0

"" vim-json
set conceallevel=0 " Don't hide quotes

"" vim-flow
let g:flow#enable = 0

" VimWiki {{{
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" }}}

" Bindings {{{

let mapleader=" "
let maplocalleader=","

" autocomplete
if has('gui_running') || has('nvim')
  inoremap <C-Space> <C-x><C-o>
else
  " terminal sends <C-Space> as <Nul> or <C-@> to vim
  imap <Nul> <C-x><C-o>
endif

function! LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction
function! LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction
nnoremap <Leader>, :call LocationPrevious()<CR>
nnoremap <Leader>. :call LocationNext()<CR>

map <Leader>ew :Errors<CR>
map <Leader>eq :lclose<CR>

" fzf
map <Leader>t :FZF<CR>

" NERDTree
map <silent> <Leader>f :NERDTreeFocus<CR>
map <silent> <Leader>\ :NERDTreeFind<CR>

" Neoformat
map <C-f> :Neoformat<CR>
imap <C-f> <C-o>:Neoformat<CR>

" Flow
autocmd FileType javascript map <buffer><silent> <Leader>i :FlowType<CR>
autocmd FileType javascript map <buffer> gd :FlowJumpToDef<CR>

" vimagit
nmap <Leader>g<Space> :Magit<CR>

" faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

map <Leader>s :update<CR>
" Clear the last used search pattern
map <Leader>d :let @/=''<CR>

"" Editing vimrc
map <Leader>ve :e ~/.vimrc<CR>
map <Leader>vr :source ~/.vimrc<CR>

" }}}
