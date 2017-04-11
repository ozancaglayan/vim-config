"""""""""""""""""""""""""
" Basic features
"""""""""""""""""""""""""
call pathogen#infect()
call pathogen#helptags()

" Display options
syntax on

" Colorscheme and terminal settings
set term=xterm-256color
set t_Co=256
set background=light
colorscheme solarized

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

filetype plugin indent on       " Do filetype detection and load custom file plugins and indent files
set cursorline
set number
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set updatecount=1000            " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set scrolloff=3 				        " Start scrolling 3 lines before the horizontal window border
"set autochdir 					        " Automatically cd into dir that the file is in
set mouse=a                     " Use mouse
set ttyfast                     " Optimize for fast terminal connections
set noerrorbells                " Disable error bells
set nostartofline               " Don’t reset cursor to start of line when moving around.
set binary                      " Don’t add empty newlines at the end of files
set colorcolumn=0
set wrap                        " Enable wrapping

"Enables to move upward/downward at long lines
map <UP> gk
map <DOWN> gj
map k gk
map j gj

autocmd BufNewFile,BufRead *.json set ft=javascript "use JS syntax for json files

" Indentation and tabbing
set autoindent
set smarttab                    " Make <tab> and <backspace> smarter
set tabstop=2
set shiftwidth=2                " Indents of 4 spaces
set expandtab
set copyindent                  " Copy indentation structure of existing lines

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :100 : up to 100 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:100,n~/.vim/viminfo

" Undo
set undolevels=10000
set undodir=~/.vim/undo       " Allow undoes to persist even after a file is closed
set undofile

"make vim save and load the folding of the document each time it loads"
""also places the cursor in the last place that it was left."
set viewdir=~/.vim

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" to_html settings
let html_number_lines = 1
let html_ignore_folding = 1
let html_use_css = 1
let xml_use_xhtml = 1

" Keybindings to native vim features
let mapleader=","
let localmapleader=","
map <Leader>ss :setlocal spell!<cr>
map <Leader>/ :nohlsearch<cr>
map <M-[> :tprev<CR>
map <M-]> :tnext<CR>
vnoremap . :normal .<CR>
vnoremap @ :normal! @
map <M-j> :bn<cr>
map <M-k> :bp<cr>

"""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""
nnoremap <C-g> :NERDTreeToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

nnoremap <C-y> :YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_manual_clipboard_check = 0

let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

let g:Powerline_symbols = 'unicode'
set laststatus=2

let g:ctrlp_map = '<C-e>'
let g:ctrlp_custom_ignore = '/\.\|\.o\|\.so'

let s:ackcommand = executable('ack-grep') ? 'ack-grep' : 'ack'
let g:ackprg=s:ackcommand." -H --nocolor --nogroup --column -a -i"
noremap <Leader>a :Ack! <cword><cr>

noremap <Leader>t= :Tabularize /=<CR>
noremap <Leader>t: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap <Leader>t> :Tabularize /=><CR>
noremap <Leader>t, :Tabularize /,\zs/l0l1<CR>
noremap <Leader>t{ :Tabularize /{<CR>
noremap <Leader>t\| :Tabularize /\|<CR>

nmap <C-t> :TagbarToggle<CR>

"""""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""""
function! CleanClose(tosave)
  if (a:tosave == 1)
      w!
  endif
  let todelbufNr = bufnr("%")
  let newbufNr = bufnr("#")
  if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
      exe "b".newbufNr
  else
      bnext
  endif
  if (bufnr("%") == todelbufNr)
      new
  endif
  exe "bd!".todelbufNr
endfunction

" Strip trailing whitespace
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>sw :call StripWhitespace()<CR>

" Always edit file, even when swap file is found
set shortmess+=A

" Toggle paste mode while in insert mode with F12
set pastetoggle=<F12>

nmap <F5> :windo set scb!<cr>
