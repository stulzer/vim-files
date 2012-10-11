set nocompatible

call pathogen#infect()
syntax on

" Auto detect filetype
filetype plugin indent on

runtime macros/matchit.vim

" Display incomplete commands
set showcmd
" Display current mode
set showmode

" Intuitive basckspace
set backspace=indent,eol,start

" Handle multiple buffer better
set hidden

" Enhanced command line commands
set wildmenu
set wildmode=list:longest

" Ignore case when search
set ignorecase
" If expression has capital letter the case is relevant
set smartcase

" Show line numbers
" set number
" Show current position
set ruler
" Add a highlight color in the current line
set cursorline

" Highlight match as you type
set incsearch
set hlsearch

" Turn on line wrapping.
set wrap
" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No more anoying beeps
set visualbell

" Don't make a backup before overwriting a file.
set nobackup
set nowritebackup
" Keep swap files in one location
set directory=$HOME/.vim/tmp//,.

" Default tab width
set tabstop=2
set shiftwidth=2
" Use spaces instead of tabs
set expandtab

" Show the status line all the time
set laststatus=2

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Best colorscheme ever =)
colorscheme solarized
set background=dark
call togglebg#map("<F5>")

" Mapping for quick js/less/scss folding
nmap ,f vi{zf

" Mapping for tab manipulation
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" For the MakeGreen plugin and Ruby RSpec
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" Allow to paste
set clipboard=unnamed

" Set line break
set linebreak
" Don't show invisibles
set nolist
" Invisibles for tab and end of line
set listchars=tab:▸\ ,eol:¬

" Blank chars colors
highlight NonText guifg=#143c46
highlight SpecialKey guifg=#143c46

" Don't use spell checker, if use Portuguese is the default language
set nospell
set spelllang=pt

" Mapping to show or hide invisibles
map <leader>d :set list!<CR>

" Creates one line above and bellow the current cursor position
nmap <Tab> O <Esc> j O <Esc>

nmap ,ras :call ReloadAllSnippets() <CR>
map ,cc :CommandT<CR>
map ,cf :CommandTFlush<CR>

" Syntax Changing
map ,jq :set syntax=jquery<CR>
map ,js :set syntax=javascript<CR>
" Execute the current file in nodejs
map ,nd :!node %<CR>

" Execute rspec
map <leader>r :!rspec --color<CR>

" Function to align key value fat arrows in ruby, and equals in js
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

" CommandT auto split window
let g:CommandTAcceptSelectionSplitMap=['<CR>', '<C-g>']
