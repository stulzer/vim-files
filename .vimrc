call pathogen#infect()

set nocompatible

syntax on

" Auto detect filetype
filetype plugin indent on

runtime macros/matchit.vim

" Display current mode
set showmode

" Intuitive basckspace
set backspace=indent,eol,start

" Handle multiple buffer better
set hidden

" Enhanced command line commands
set wildmenu
set wildmode=list:longest

" Ignore certain folders
set wildignore+=public/uploads
set wildignore+=.sass-cache
set wildignore+=node_modules
set wildignore+=temp
set wildignore+=public/spree
set wildignore+=tmp
set wildignore+=bower
set wildignore+=bower_components
set wildignore+=dist
set wildignore+=src/main/webapp/static
set wildignore+=src/main/webapp/v/static
set wildignore+=build
set wildignore+=.keep
set wildignore+=.rspec
set wildignore+=spec/cassettes

" Ignore case when search
set ignorecase
" If expression has capital letter the case is relevant
set smartcase

" Remaping the <Leader> key.
let mapleader = ","

" Show line numbers
set number

" Highlight match as you type
set incsearch
set hlsearch

" Turn on line wrapping.
set wrap
" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No more annoying beeps
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
set pastetoggle=<F12>

" colorscheme Tomorrow
" set background=light
colorscheme heroku-terminal
set background=dark

" Mapping for tab manipulation
map <leader>tt :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tm :tabmove

nnoremap <Leader>w :w<cr>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Detecting rails binstubs for rspec
if filereadable("bin/rspec")
  let g:vroom_use_binstubs = 1
else
  let g:vroom_use_binstubs = 0
end

" Trigger to run the whole RSpec suite
function ClearScreenAndRunRSpec()
  :silent !clear
  if filereadable("bin/rspec")
    : !./bin/rspec
  else
    : !bundle exec rspec
  end
endfunction
map <leader>R :call ClearScreenAndRunRSpec()<cr>

" For the MakeGreen plugin and Ruby RSpec
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

"for ruby, autoindent with two spaces, always expand tabs
autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
autocmd FileType python set sw=4 sts=4 et

autocmd! BufRead,BufNewFile *.sass setfiletype sass

" Set line break
set linebreak
" Don't show invisibles
set nolist
" Invisibles for tab and end of line
set listchars=tab:▸\ ,eol:¬,trail:·

" Blank chars colors
highlight NonText guifg=#143c46
highlight SpecialKey guifg=#143c46

" spell checker, Portuguese and English as default language
set spelllang=pt,en_us
set spell

" fast nohighligth
map <leader>q :noh<cr>
" Mapping to show or hide invisibles
map <leader>l :set list!<cr>
" Execute the current file in nodejs
map <leader>nd :!node %<cr>
" Mapping for quick js/less/scss folding
nmap <leader>f vi{zf
" Execute test unit
map <leader>u :!clear && bundle exec rake test TEST=%<cr>
map <leader>U :!clear && bundle exec rake<cr>

" Function to align key value fat arrows in ruby, and equals in js, stolen
" from @tenderlove vimrc file.
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <leader>a :Align<cr>
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

if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
  " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2
endif

" Nice way to corret typos saving, editing and deleting buffers
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang -nargs=* -complete=file Bd bd<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
  command! -bang Bd bd<bang>
endif

" Removed the slow rake routes function from bash
function! ShowRoutes()
  " requires vim-scratch plugin
  :topleft 100 :split __Routes__
  :set buftype=nofile
  :normal 1GdG
  :0r! bundle exec rake -s routes
  :exec ":normal " . line("$") . "^W_ "
  :normal 1GG
  :normal dd
endfunction
map <leader>cR :call ShowRoutes()<cr>

" CtrlP mapings
map <leader>os :CtrlPClearCache<cr>\|:CtrlP public/scss<cr>
map <leader>oi :CtrlPClearCache<cr>\|:CtrlP public/images<cr>
map <leader>oh :CtrlPClearCache<cr>\|:CtrlP public/handlebars<cr>
map <leader>om :CtrlPClearCache<cr>\|:CtrlP public/modules<cr>
map <leader>og :topleft 100 :split Gruntfile.js<cr>
map <leader>va :CtrlPClearCache<cr>\|:CtrlP src/main/webapp-resources/assets<cr>
map <leader>vm :CtrlPClearCache<cr>\|:CtrlP src/main/webapp/mustache<cr>
map <leader>cv :CtrlPClearCache<cr>\|:CtrlP app/views<cr>
map <leader>ct :CtrlPClearCache<cr>\|:CtrlP app/controllers<cr>
map <leader>cm :CtrlPClearCache<cr>\|:CtrlP app/models<cr>
map <leader>ch :CtrlPClearCache<cr>\|:CtrlP app/helpers<cr>
map <leader>cs :CtrlPClearCache<cr>\|:CtrlP spec<cr>
map <leader>cl :CtrlPClearCache<cr>\|:CtrlP lib<cr>
map <leader>ca :CtrlPClearCache<cr>\|:CtrlP app/assets<cr>
map <leader>ci :CtrlPClearCache<cr>\|:CtrlP app/assets/images<cr>
map <leader>cc :CtrlPClearCache<cr>\|:CtrlP<cr>
map <leader>cr :topleft 100 :split config/routes.rb<cr>
map <leader>cg :topleft 100 :split Gemfile<cr>

" Alternate between last opened buffer
nnoremap <leader><leader> <c-^>

" Makes ctrlp FASTER THAN HELL
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
        \ }
endif

" End of line and First non-blank chracter of the line
vnoremap H ^
vnoremap L $
nnoremap H ^
nnoremap L $

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Automaticaly create a directory in the current file
map <leader>md :silent !mkdir -p %%<cr> :redraw! <cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>r :call RenameFile()<cr>

augroup vimrcEx
  " Clear all autocmd in the group
  autocmd!

  " open vim in the last position of the file that you were editing
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" searching commands
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <C-n> :NERDTree <cr>

" delimitMate configuration
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = ""

" Cucumber
nnoremap <leader>A :!clear; ruby %<cr>
nnoremap <leader>a :!clear; ruby %<cr>

" Easy way to add and subtract numbers
nnoremap + <C-a>
nnoremap - <C-X>
nnoremap _ <C-X>

" Remapping the reversal find
nnoremap <C-f> ,
vnoremap <C-f> ,

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Show syntax highlighting groups for word under cursor
nmap <C-S-X> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set viminfo='50,<10000,s1000,:1
" '50 Marks will be remembered for the last 50 files you edited.
" <10000 Contents of registers (up to 10000 lines each) will be
" remembered.
" s1000 Registers with more than 1 Mb text are skipped.
" :1 Actives command-line history

set history=2000
" Stores up to 2000 commands types on command-line mode

" Highlight Whitespaces to not forget them
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" Show whitespaces as dots and End of Line as ¬
" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" nnoremap <silent> <leader>fw :call TrimWhiteSpace()<CR>

" autocmd FileWritePre    * :call TrimWhiteSpace()
" autocmd FileAppendPre   * :call TrimWhiteSpace()
" autocmd FilterWritePre  * :call TrimWhiteSpace()
" autocmd BufWritePre     * :call TrimWhiteSpace()

nnoremap <silent> <leader>g :! cd ~/Code/vivareal-site/src/main/webapp-resources/grunt && grunt<CR>

let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }

" powerline stuff
python import sys; sys.path.append("/Users/stulzer/Library/Python/2.7/bin/")
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
