set guifont=Inconsolata\ for\ Powerline:h20
set antialias
set encoding=utf-8
set guioptions-=T

set guioptions-=r
set nolist
set listchars=tab:▸\ ,eol:¬
set go-=L

set columns=213
set lines=51

highlight NonText guifg=#1a3c46
highlight SpecialKey guifg=#1a3c46

colorscheme heroku
set background=dark

set nofu

if has("gui_macvim")
  set fuoptions=maxhorz,maxvert
end
