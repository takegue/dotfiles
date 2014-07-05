" ~/git/dotfiles/vimfiles/sessions/default.vim:
" Vim session script.
" Created by session.vim 2.4.14 on 05 7月 2014 at 23:14:17.
" Open this file in Vim and run :source % to restore your session.

if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'molokai' | colorscheme molokai | endif
call setqflist([{'lnum': 6, 'col': 1, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'template/test_template.py', 'text': 'E302 expected 2 blank lines, found 1'}])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/git/dotfiles/vimfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 template/test_template.py
badd +1 /lab/takeno/codes/research/SimpleJW/tools/wiki_tools
badd +51 /lab/takeno/codes/research/SimpleJW/tools/wiki.py
badd +1 /lab/takeno/codes/research/SimpleJW/tools/wiki_alignment.py
badd +40 ~/.vimrc
badd +1 /lab/takeno/codes/research/SimpleJW/tools/mytools.py
badd +7 /lab/takeno/codes/research/SimpleJW/tools/__init__.py
badd +1 /lab/takeno/codes/research/SimpleJW/tests/test_mytools.py
badd +1 /lab/takeno/codes/research/SimpleJW/tests/test_mecabomod.py
badd +1 /lab/takeno/codes/research/SimpleJW/tests/test_analyze_wikidatasets.py
badd +1 /lab/takeno/codes/research/SimpleJW/tests/test_extract_dataset.py
badd +1 /lab/takeno/codes/research/SimpleJW/tests/test_ms_translator.py
badd +10 /lab/takeno/codes/research/SimpleJW/tests/test_wiki_alignment.py
badd +28 conf.d/bundle/bundle-programming.vim
badd +3 /lab/takeno/codes/research/SimpleJW/tests/__init__.py
badd +1 template/template.py
badd +8 /lab/takeno/codes/research/SimpleJW/tests/test_wiki.py
badd +1 after/ftplugin/markdown.vim
badd +1 after/ftplugin/vim.vim
badd +5 after/ftplugin/python.vim
badd +1 snippets/pytest.snip
badd +73 conf.d/bundle/bundle-util.vim
badd +11 conf.d/basic.vim
badd +15 conf.d/map.vim
badd +0 /lab/takeno/codes/research/vimfiler:explorer@3
badd +0 vimfiler:explorer@6
badd +0 ~/.vim/ftplugin/vim.vim
silent! argdel *
edit /lab/takeno/codes/research/SimpleJW/tools/wiki_alignment.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 84 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 83 + 84) / 168)
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 15 - ((4 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0
lcd /lab/takeno/codes/research/SimpleJW
wincmd w
" argglobal
edit /lab/takeno/codes/research/SimpleJW/tests/test_wiki_alignment.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 8 - ((1 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 0
lcd /lab/takeno/codes/research/SimpleJW
wincmd w
exe 'vert 1resize ' . ((&columns * 84 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 83 + 84) / 168)
tabedit ~/git/dotfiles/vimfiles/after/ftplugin/markdown.vim
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 52 - ((29 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
52
normal! 0
lcd ~/
wincmd w
" argglobal
edit ~/git/dotfiles/vimfiles/snippets/pytest.snip
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 67 - ((21 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
67
normal! 0
lcd ~/git/dotfiles/vimfiles
wincmd w
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
tabedit /lab/takeno/codes/research/SimpleJW/tools/mytools.py
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 34 - ((18 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
34
normal! 034|
lcd /lab/takeno/codes/research/SimpleJW
tabedit ~/git/dotfiles/vimfiles/template/test_template.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 8 - ((0 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 0
lcd ~/git/dotfiles/vimfiles
wincmd w
" argglobal
edit ~/git/dotfiles/vimfiles/conf.d/bundle/bundle-util.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 62 - ((0 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 022|
lcd ~/git/dotfiles/vimfiles
wincmd w
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
tabedit ~/git/dotfiles/vimfiles/conf.d/bundle/bundle-util.vim
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 63 - ((10 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
63
normal! 016|
lcd ~/git/dotfiles/vimfiles
tabnext 5
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 5
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
