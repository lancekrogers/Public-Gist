set nocompatible              " required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'tmhedberg/SimpylFold'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'

" Other Tools
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'Valloric/YouCompleteMe'
Plug 'kana/vim-fakeclip'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'Konfekt/FastFold'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'adelarsq/vim-matchit'
Plug 'lfv89/vim-interestingwords'
Plug 'dhruvasagar/vim-table-mode'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" HTML Boilerplate
Plug 'mattn/emmet-vim'

" Plug 'mitchpaulus/autocorrect.vim'

" Hex colors
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
"Plug 'KabbAmine/zeavim.vim'

" Syntax Stuff
Plug 'dense-analysis/ale'

" Syntax Highlighing
Plug 'sheerun/vim-polyglot'
Plug 'lepture/vim-jinja'
Plug 'Quramy/vim-js-pretty-template'

" React
"Plug 'mxw/vim-jsx'

" Smart Contracts
Plug 'rnestler/michelson.vim'
Plug 'jacqueswww/vim-vyper'
Plug 'aldur/vim-algorand-teal'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Python packages
" Plug 'python-mode/python-mode'

" Doesn't work on popos desktop for some unknown reason
Plug 'nvie/vim-flake8'

" Javascript
Plug 'moll/vim-node'
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Golang
Plug 'fatih/vim-go'

" Color Scemes
Plug 'jnurmine/Zenburn'
Plug 'yassinebridi/vim-purpura'
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
"Plug 'lancekrogers/vim-colorstepper'

call plug#end()

" Enable folding
set foldmethod=indent |
set foldlevel=99

" Show search count
set shortmess-=S

" Enable folding with the spacebar
nnoremap <space> za

au BufNewFile,BufRead *.py,*.vy
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set colorcolumn=80 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.ts,*.js,*.html,*.css,*.jsx,*.sql,*.sol
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=99 |
    \ set colorcolumn=100 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.sh,*.vimrc
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |


set encoding=utf-8

" YCM ycm YouCompleteMe settings
" let g:ycm_python_binary_path='python'

set fdm=marker
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" function! ToggleYCM()
"   if g:ycm_auto_trigger == 1
" 	let g:ycm_auto_trigger = 0 
" 	echo "YCM Auto complete OFF"
"   else
" 	let g:ycm_auto_trigger = 1
" 	echo "YCM Auto complete ON"
"   endif
" endfunction

let python_highlight_all=1
syntax on

" Toggle Colorscheme
let g:colorcode = 0

" Default colorscheme
set termguicolors
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
colorscheme gruvbox 
set background=dark
hi Normal ctermbg=none

function! ToggleLightDark()
  if &background=="dark"
      echo "LET THERE BE LIGHT" 
      set background=light
  elseif &background=="light"
      echo "LET THERE BE DARKNESS"
      set background=dark
  endif
endfunction

function! ToggleColorScheme()
  if g:colorcode == 0
    colorscheme gruvbox
    
    let g:colorcode = 1    
    echo "colorscheme set to gruvbox"
  elseif g:colorcode == 1
    colorscheme purpura 
    hi Normal ctermbg=none
    let g:colorcode = 2
  else
    colorscheme koehler 
    echo "colorscheme set to koehler"
    let g:colorcode = 0
  endif
endfunction

" call togglebg#map("<F4>")

let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

set clipboard=unnamed 
noremap <leader>Y "+y
noremap <leader>P "+p

" Reload
nnoremap <leader>l <C-L>

" Window navigation
autocmd VimEnter * nnoremap <C-J> <C-W><C-J>
autocmd VimEnter * noremap <C-K> <C-W><C-K>
autocmd VimEnter * noremap <C-L> <C-W><C-L>
autocmd VimEnter * noremap <C-H> <C-W><C-H>

"autocmd VimEnter * NERDTreeToggle

let $BASH_ENV = '~/.bash_profile'

set spelllang=en

autocmd BufRead,BufNewFile *.md setlocal spell

" autocmd BufRead,BufNewFile *.txt setlocal spell

autocmd BufRead,BufNewFile *.tex setlocal spell

autocmd BufRead,BufNewFile *.html setlocal spell

let g:javasxript_plugin_flow = 1
let g:jsx_ext_required = 0


autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
 set wildmenu
" NOW WE CAN:
" -- Hit tab to :find by partial match
" -- Use * to make it fuzzy

" THINGS TO CONSIDER:
"  -- :b lets you autocomplete any open buffer

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
    if &spell
        echo "Spellcheck ON"
    else
        echo "Spellcheck OFF"
    endif
endfunction

" Custom toggles
nnoremap <F6> :call ToggleColorScheme()<CR>
nnoremap <F2> :call ToggleLightDark()<CR>

nnoremap <silent> S :call ToggleSpellCheck()<CR>
" nnoremap <silent> C :call ToggleYCM()<CR> 

" Toggle NERDTree
nmap <silent><C-n> :NERDTreeToggle<CR>

" Toggle tag bar
nmap <silent><F8> :TagbarToggle<CR>
nmap <silent><F9> :TagbarOpenAutoClose<CR> 
let g:tagbar_show_linenumbers = 1

" Always show statusline
if !exists('laststatus')
  set laststatus=2
endif

" Syntastic config

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_auto_loc_list = 1

"" Previous enabled settings are below
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>


" Git fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>


" Javascript
let g:ale_linters = {
            \'javascript': ['eslint'],
            \'python': ['flake8', 'bandit']                 
            \}
let g:ale_javascript_eslint_exectuabl='npx eslint'
" let g:ale_echo_cursor = 0

" Tern go to definition enable keyboard shortcuts
let g:tern_map_keys=1

"tern show argument hints
let g:tern_show_argument_hints='on_hold'

" Enable mouse support for normal mode
set mouse=nv

" Find cursor easier
set cursorline

set nu
set rnu

" Toggle line number modes
nnoremap <silent><F7> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR> 

" Custom json formatter function
function! FormatJSON()

  :%s/True/true 
  :%s/False/false
  :%s/'\([^']*\)'/\='"'.tr(submatch(1), '"', "'").'"'/g
  :w
  try
    :%!python -m json.tool
  catch
    echo "Python json.tool returned an error"
  endtry
endfunction

nnoremap <silent> <leader>jf :call FormatJSON()<CR>

" Search And Grep to Ag Updates

" Silversearcher grep
if executable('ag') 
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" Internet search https://github.com/rajasegar/vim-search-web
nnoremap /// :OpenDuckduckgoSearch(

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:gitgutter_grep = 'ag'

nmap <silent> .<RIGHT> :GitGutterNextHunk<CR>
nmap <silent> .<LEFT> :GitGutterPrevHunk<CR>
nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

" bind // (double slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap // :Ag<SPACE>

" fzf
" This is the default extra key bindings

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-l': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

nnoremap <c-p> :FZF<cr>

" Open current file in a browser
nmap <F5> :w <Bar> !xdg-open %<CR>


let g:NERDSpaceDelims = 1


" let g:AutocorrectFiletypes = ["text","markdown","tex"]


" Notes
let g:notes_directories = ['~/Desktop/Notes']
let g:notes_suffix = '.txt'

" HTML Boilerplate
let g:user_emmet_leader_key=','
