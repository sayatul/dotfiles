set nocompatible              " be iMproved, required
filetype off                  " required


" -----------------------------------------------------------------------------
" configure Plugins and vundle
" -----------------------------------------------------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')syntax on
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'Yggdroot/indentLine'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'itchyny/lightline.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'preservim/tagbar'
Plugin 'junegunn/fzf.vim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'b4b4r07/vim-sqlfmt'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=/usr/local/opt/fzf
" -----------------------------------------------------------------------------
" configure editor basic stuff
" -----------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set background=dark
set number
set colorcolumn=80      " set line marker at 79 char
set showcmd             " show (partial) command in status line
set showmatch
set splitright          "split to right
set splitbelow          "shlit below
set hlsearch            "highlight search
set noswapfile          "ignore swap
syntax enable
set tabstop=2
set shiftwidth=2
set conceallevel=0
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set wildmode=longest,list       "full optional

set guifont=Monaco:h14

"Automatically_removing_all_trailing_whitespace
autocmd BufWritePre *.py %s/\s\+$//e
autocmd BufWritePre *.js %s/\s\+$//e
autocmd BufWritePre *.xml %s/\s\+$//e
autocmd BufWritePre *.yml %s/\s\+$//e

"Move b/w panes Cmd Opt Arrow
nnoremap <D-A-Right> <C-W><C-L>
nnoremap <D-A-Left> <C-W><C-H>
nnoremap <D-A-Down> <C-W><C-J>
nnoremap <D-A-Up> <C-W><C-K>

"Get class and method name above cursor
nnoremap <C-s> :echo getline(search('^class', 'bn')) . ">" . getline(search('^\s*def', 'bn'))<CR>

"configure ALE
let b:ale_linters = ['xmllintr']
let b:ale_linters = ['flake8', 'pylint']
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" -----------------------------------------------------------------------------
" configure look & feel of editor
" -----------------------------------------------------------------------------

" Color Scheme
let g:enable_bold_font = 1
set background=dark
colorscheme hybrid_material
" colorscheme termschool
" colorscheme solarized8
let g:material_terminal_italics = 1

"airlline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = "hybrid"
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy

"https://github.com/scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
nnoremap ,c :call NERDComment(0,"toggle")<CR>
vnoremap ,c :call NERDComment(0,"toggle")<CR>

"needtree config
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
" enable line numbers
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore = ['\.pyc$', '\.DS_Store$', '\.pytest_cache$', '\.git$']

"tagbar
nmap <C-t> :TagbarToggle<CR>

"https://github.com/Yggdroot/indentLine
let g:indentLine_char = '|'
let g:indentLine_faster = 1

"go 
let g:go_fmt_autosave = 0

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

"insert pdb on cursor line
map <Leader>p :call InsertPdb()<CR>
function! InsertPdb()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal o".trace
endfunction

"insert js debugger on cursor line
map <Leader>d :call InsertDebugger()<CR>
function! InsertDebugger()
  let trace = expand("debugger;")
  execute "normal o".trace
endfunction

command! Q :q
command! E :e
command! W :w
command! Wq :wq

" FZF
nnoremap <C-p> :GFiles<Cr>
