set guifont=Inconsolata:h16
set antialias
set encoding=utf-8
set guioptions-=T
set lines=60 columns=250
set fu

set guioptions-=r
colorscheme solarized
set background=dark
set nolist
set listchars=tab:▸\ ,eol:¬
set go-=L

highlight NonText guifg=#1a3c46
highlight SpecialKey guifg=#1a3c46

if has("gui_macvim")
  set fuoptions=maxhorz,maxvert
end
