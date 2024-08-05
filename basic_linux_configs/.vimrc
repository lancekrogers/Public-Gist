" Enable relative line numbers
set relativenumber

" Enable line numbers
set number

" Enable mouse and 256 bit colors if available
syntax on
set mouse=a
set t_Co=256
colorscheme desert

" Enable incremental search
set incsearch

" Highlight search results
set hlsearch

" Highlight the current line
set cursorline

" Show matching parentheses
set showmatch

" Set last status line and color column
set laststatus=2
set colorcolumn=120

" Basic settings for a better editing experience
set nocompatible
set backspace=indent,eol,start
set ruler
set showcmd

" Blink cursor for specific terminals
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"
endif

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Remapped commands
nnoremap <leader>e :Lexplore<CR>:setlocal relativenumber<CR>:setlocal number<CR>
nnoremap <leader>m :call ToggleMouse()<CR>
nnoremap <leader>s :mksession! ~/session.vim<CR>
nnoremap <leader>r :source ~/session.vim<CR>
nnoremap tt :bnext<CR>
nnoremap tT :bprev<CR>
nnoremap <leader>ls :ls<CR>

" Filetype specific settings
aug python
  " Filetype python.vim overwrites this
  au FileType python setlocal ts=4 sts=4 sw=4 expandtab
  set autoindent
  set smartindent
  " Set make program for Python files
  au FileType python setlocal makeprg=pyflakes\ %
  " Set errorformat for pyflakes
  au FileType python setlocal errorformat=%f:%l:%c:\ %m
  " Automatically run pyflakes on buffer write
  au BufWritePost *.py silent! make | cwindow
aug end

" Define a command to run pyflakes and populate the quickfix list
command! Pyflakes :w<CR>:make<CR>

" Key mappings for quickfix navigation
nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprev<CR>
nnoremap <silent> <leader>co :copen<CR>
nnoremap <silent> <leader>cc :cclose<CR>

" Use spaces instead of tabs
set expandtab
set shiftwidth=4
set tabstop=4

" n to open jump list and prompt for a jump index
function! JumpToIndex()
  " open the jump list
  :jumps
  " Prompt the user for a jump index
  let l:index = input("Enter jump index: ")
  " check if the input is a valid number
  if l:index =~ '^\d\+$'
    " Convert the input to a number
    let l:index = str2nr(l:index)
    " Jump to the specified index (subtract 1 because the current position is index 1)
    if l:index > 0
      execute 'normal!' (l:index - 1) . "\<c-o>"
    endif
  else
    echo "Invalid index"
  endif
endfunction

" Map <leader>j to the JumpToIndex function
nnoremap <silent> <leader>j :call JumpToIndex()<CR>

" Functions
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
    echo "Mouse support enabled"
  endif
endfunction

" Python linting with pyflakes
command! Pyflakes :w<CR>:make<CR>
