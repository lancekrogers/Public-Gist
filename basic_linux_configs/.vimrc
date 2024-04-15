"enable relative line numbers, syntax highlighting and turn off swp files
set relativenumber

set number

syntax on

set nobackup

"Enable mouse and 256 bit colors if available
set mouse=a

set t_Co=256

colorscheme elflord

"Highlight the current line and add a max line length mark
set cursorline

set statusline="%f, %=%l,%c

set laststatus=2

set colorcolumn=120

"blink cursor
if &term =~ 'xterm\|rxvt'
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[1 q"
endif

" Set tabs to 2 spaces
set tabstop=2

set shiftwidth=2

set expandtab

" Remapped commands
nnoremap <leader>e :Lexplore<CR>:setlocal relativenumber<CR>:setlocal number<CR>
nnoremap <leader>m :call ToggleMouse() <CR>

nnoremap <leader>s :mksession! ~/session.vim<CR>

nnoremap <leader>r :source ~/session.vim<CR>

nnoremap tt :bnext<CR>

nnoremap tT :bprev<CR>

nnoremap <leader>b] :ls<CR>

" Filetype specific settings
augroup python
" ftype/python.vim overwrites this
    au FileType python setlocal ts=4 sts=4 sw=4 expandtab
    set autoindent
    set smartindent
augroup END

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
