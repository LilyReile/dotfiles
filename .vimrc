" autoindentation on (newline starts with previous line's indentation)
set autoindent

" smartindent off (just let my indentation be, thanks)
set nosmartindent

" make sure a non-empty indentexpr does not override nosmartindent
set indentexpr=

" Disable filetype-based indentation settings
filetype indent off

" when indenting with '>', use 2 spaces
set shiftwidth=2

" on pressing tab, insert spaces instead
set expandtab

" define a tab's width as 2 columns (expandtab will know that 2 columns == 2 spaces)
set tabstop=2

" enable line numbers
set number

" enable syntax highlighting
syntax enable

" disable syntax highlighting for long lines because it's painfully slow
set synmaxcol=128

" set the colorscheme
colorscheme monokai

" override the colorscheme's background to dark black
highlight Normal ctermbg=Black
highlight LineNr ctermbg=Black

" set default folding to the syntax method
set foldmethod=syntax

" don't fold by default -- folds must be explicit
set nofoldenable

" lowercase searches match miXEd CAse. Uppercase searches match UPPERCASE only
set ignorecase smartcase

" always allow backspace
set backspace=indent,eol,start

" https://github.com/junegunn/vim-plug plugin manager
call plug#begin()
  " fuzzy finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

  " Ag inside VIM!
  Plug 'mileszs/ack.vim'

  " add some unix commands to VIM (:move, :delete, etc.)
  Plug 'tpope/vim-eunuch'

  " trailing whitespace highlighting
  Plug 'ntpeters/vim-better-whitespace'

  " syntax highlighting for slim templates
  Plug 'slim-template/vim-slim'

  " syntax highlighting for jsx
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'

  " Install my colorscheme to ~/.vim/colors/
  Plug 'https://github.com/sickill/vim-monokai'

  " coffescript syntax highlighting an features
  Plug 'kchmck/vim-coffee-script'

  " Add Startify screen for persistent session management
  Plug 'mhinz/vim-startify'

  " Highlight color values in the colors they represent
  Plug 'chrisbra/Colorizer'

  " See git blame in vim
  Plug 'zivyangll/git-blame.vim'
call plug#end()

" tell vim-gista to use my github account for authorization
let g:gista#client#default_username = 'DylanReile'

" fuzzy finder taller window
let g:fzf_layout = { 'down': '~80%' }

" initiate fuzzy finder with :z instead of :FZF
cnoreabbrev z FZF

" variable for ag command with default switches
let agCommand = 'ag --vimgrep --hidden --path-to-ignore ~/.agignore'

" have ack.vim use ag for searching
let g:ackprg = agCommand
cnoreabbrev ag Ack

" have fzf use ag to find candidate paths
let $FZF_DEFAULT_COMMAND = agCommand . ' -g ""'

augroup myvimrchooks
    " clear autocmds to make registering them idempotent
    au!

    " I don't know how indentexpr keeps getting set to a non-empty string.
    " I always want it to be empty so that my freakin' indentation isn't
    " messed up.
    au bufenter * set indentexpr=

    " switch folding method to indent for certain extensions
    au bufnewfile,bufreadpost *.coffee,*.haml,*.slim,*.inky,*yml setl foldmethod=indent

    " switch folding method to {,} marker for CSS files
    au bufread,bufnewfile *.css,*.scss,*.less setl foldmethod=marker foldmarker={,}

    " switch syntax to slim for inky extensions
    au bufnewfile,bufreadpost *.inky setl syntax=slim

    " strip trailing whitespace on every save
   au bufenter * EnableStripWhitespaceOnSave

    " autosource changes to yours truly
    au bufwritepost .vimrc source ~/.vimrc

    " write changes to yours truly to my public Gist
    " au bufwritepost .vimrc Gista patch dae4d045d3432feedd584432ff6ba11e -f --stay -u=DylanReile
augroup END

" enable switching between buffers without saving
set hidden

" always yank into/paste from the system clipboard
set clipboard=unnamed

" The new engine (2) has a bad lag. This drastically improves performance!
set regexpengine=1

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" use :yf to yank current file path into the system clipboard
cnoreabbrev yf let @+=expand("%:.")

""" Leaders """
" set leader key to space
let mapleader = " "
" b to open the previous buffer
map <leader>b :b#<cr>
" z to open FZF
map <leader>z :FZF<cr>
" my to open $MYVIMRC
map <leader>my :e $MYVIMRC<cr>
" w to work with splits
map <leader>w <C-w>
" ; to repeat last normal mode command
map <leader>; :@<cr>
" bl to see git blame for current line in status bar
map <leader>bl :<C-u>call gitblame#echo()<CR>


" :mv alias for :Move
cnoreabbrev mv Move

" :rm alias for :Delete
cnoreabbrev rm Delete

" % to jump between opposing characters (do matches end, [ matches ], etc.)
runtime macros/matchit.vim

" display a light green border on the 81st column
set colorcolumn=81
highlight ColorColumn ctermbg=29

" always show status line
let laststatus = 2

" supress prompt asking to okay automatic whitespace deletion
let g:strip_whitespace_confirm = 0
