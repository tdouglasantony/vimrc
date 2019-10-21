" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
:set relativenumber
:set number
execute pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible
inoremap ;<space><space> <Esc>/<++><Enter>"_c4l

"LATEX COMMAND SET
"Automatic begin/end tags
autocmd FileType tex inoremap ;beg \begin{<++>}<Enter>\end{<++>}<Enter><++><Esc>3ki
autocmd FileType tex inoremap ;ma  \begin{math}<Enter>\end{math}<Enter><Esc>2k$a<Enter>
autocmd FileType tex inoremap ;al  \begin{align*}<Enter>\end{align*}<Enter><Esc>2k$a<Enter>
autocmd FileType tex inoremap ;ni \noindent
autocmd FileType tex inoremap ;tm \noindent\textbf{<++>} \\ \\ <Enter> \noindent\textit{Proof}<++> $\qed$ \\<Esc>2ki
autocmd FileType tex inoremap ;df \noindent\textbf{Definition <++>}:<Esc>0i

"C COMMAND SET
autocmd FileType c inoremap ;cs #include<stdio.h><Enter><Enter>main()<Enter>{<Enter><Enter>}<Esc>ki

"C++ COMMAND SET
autocmd FileTYPE cpp inoremap ;cs #include<iostream><Enter>using namespace std;<Enter><Enter>int main()<Enter>{<Enter><++><Enter><backspace>return 0;<Enter>}<Esc>ggi<Enter><Esc>ki
autocmd FileType cpp inoremap ;fl for(int i = <++>; i < <++>; i++)<Enter>{<Enter><Enter>}<Esc>3k0i
autocmd FileType cpp inoremap ;wl while()<Enter>{<Enter><++><Enter>}<Esc>3kwa

"HTML COMMAND SET
autocmd FileType html inoremap ;hs <!DOCTYPE html><Enter><html lang="en"><Enter><head><Enter><meta charset="utf-8"><Enter><title></title><Enter></head><Enter><body><Enter><++><Enter></body><Enter></html><Esc>5k3wa
autocmd FileType html inoremap ;ta <<++>></<++>><Esc>0i
