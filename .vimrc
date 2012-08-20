set nocompatible

call pathogen#infect()
syntax on

filetype plugin indent on

runtime macros/matchit.vim

set showcmd
set showmode

set backspace=indent,eol,start

set hidden

set wildmenu
set wildmode=list:longest

set ignorecase
set smartcase

set number
set ruler

set incsearch
set hlsearch

set wrap
set scrolloff=3

set title

set visualbell

set nobackup
set nowritebackup
set directory=$HOME/.vim/tmp//,.

set tabstop=2
set shiftwidth=2
set expandtab

set laststatus=2
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

colorscheme solarized

nmap ,f vi{zf

map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

autocmd BufNewFile,BufRead *_spec.rb compiler rspec
set clipboard=unnamed

set nolist
set listchars=tab:▸\ ,eol:¬

highlight NonText guifg=#143c46
highlight SpecialKey guifg=#143c46

let g:LustyExplorerSuppressRubyWarning = 1

set nospell
set spelllang=pt

map <leader>d :set list!<CR>
nmap <Tab> O <Esc> j O <Esc>
nmap ,ras :call ReloadAllSnippets() <CR>
map ,cc :CommandT<CR>
map ,cf :CommandTFlush<CR>
map ,jq :set syntax=jquery<CR>
map ,js :set syntax=javascript<CR>
map ,nd :!node %<CR>

map <leader>r :!rspec --color<CR>

set background=dark
call togglebg#map("<F5>")

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

let g:CommandTAcceptSelectionSplitMap=['<CR>', '<C-g>']
