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

    " Define the Black function
    function! Black()
        let l:current_view = winsaveview()
        " Format the buffer using black and capture the output
        let l:tempfile = tempname()
        call writefile(getline(1, '$'), l:tempfile)
        let l:output = system('black --quiet --line-length 120 ' . shellescape(l:tempfile) . ' && cat ' . shellescape(l:tempfile))
        " Check if black made any changes
        if v:shell_error != 0
            " Display the error message
            echohl ErrorMsg | echo "Black failed to format the file" | echohl None
        else
            " Read the formatted content back into the buffer
            silent! %delete _
            silent! execute 'read !cat ' . shellescape(l:tempfile)
            " Restore the view position
            call winrestview(l:current_view)
            " Show success message in statusline
            echo "Black: file formatted"
        endif
        call delete(l:tempfile)
    endfunction

    " Automatically run black on buffer write
    au BufWritePre *.py call Black()
aug end


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
    echo "Mouse support disabled"
  else
    set mouse=a
    echo "Mouse support enabled"
  endif
endfunction

" Python linting with pyflakes
command! Pyflakes :w<CR>:make<CR>


function! Black()
  let l:current_view = winsaveview()
  silent! execute '%!black --line-length=120 -S'
  call winrestview(l:current_view)
endfunction


function! GotoProjectDefinition()
    let symbol = expand('<cword>')
    let path = getcwd()
    py3 << EOF
import ast
import os
import vim

def find_definition(symbol, path):
    for root, _, files in os.walk(path):
        for file in files:
            if file.endswith(".py"):
                filepath = os.path.join(root, file)
                with open(filepath, "r", encoding="utf-8") as f:
                    try:
                        tree = ast.parse(f.read(), filename=file)
                        for node in ast.walk(tree):
                            if isinstance(node, (ast.FunctionDef, ast.ClassDef)) and node.name == symbol:
                                print(f"{filepath}:{node.lineno}")
                                vim.command(f'call setqflist([{{"filename": "{filepath}", "lnum": {node.lineno}}}], "r")')
                                vim.command(f'edit +{node.lineno} {filepath}')
                                return
                    except SyntaxError:
                        continue
    print("Definition not found")

symbol = vim.eval("symbol")
path = vim.eval("path")
find_definition(symbol, path)
EOF
endfunction

nnoremap <silent> <leader>gd :call GotoProjectDefinition()<CR>
