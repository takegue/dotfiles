" Author: TKNGUE
" URL: https://github.com/TKNGUE/dotfiles
" Description:
"   This is TKNGUE's vimrc
scriptencoding utf-8

" Startup {{{ =======================
" NOTE: Skip initialization for tiny or small.
if !1 | finish | endif
if !&compatible | set nocompatible | endif      " Disable vi compatible

" Echo startup time on start:{{{
if has('vim_starting') && has('reltime')
  " Shell: vim --startuptime filename -q; vim filename
  " vim --cmd 'profile start profile.txt' --cmd 'profile file $HOME/.vimrc' +q && vim profile.txt
  let g:startuptime = reltime()
  augroup VimStart
    autocmd!
    autocmd VimEnter *
          \ let g:startuptime2 = reltime(g:startuptime)
          \ | echomsg 'time:' . reltimestr(g:startuptime2)
          \ | autocmd! VimStart VimEnter
  augroup END
endif
" }}}
" ====================== }}}
if v:version < 740 && !has('nvim')
  source ~/.min.vimrc
  finish
endif

" Vim Setup ===================== {{{
"System Settings: {{{
if has('nvim')
  let b:venv = tkngue#util#system("python3 -c 'import sys; print(\"vim_dev{v.major}\".format(v=sys.version_info), end=\"\")'")
  let g:python3_host_prog = $HOME . '/.venv/' . b:venv . '/bin/python'
  if !executable(g:python3_host_prog)
      let g:python3_host_prog  = substitute(tkngue#util#system('which python3'), '\v(\n|\s)+$', '', 'g')
  endif
  let g:python_host_prog = g:python3_host_prog
elseif has('gui_macvim')
endif
"}}}

" Encodings: {{{
" set encoding=utf8
set termencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
" }}}

" Display: {{{

if exists('&ambiwidth')
  " For Ubuntu: gnome-terminal, terminator, guake
  "   /bin/sh -c "VTE_CJK_WIDTH=1 terminator -m"
  "   /bin/sh -c "VTE_CJK_WIDTH=1 gnome-terminal --disable-factory"
  "   /bin/sh -c "VTE_CJK_WIDTH=1 guake"
  "   https://gist.github.com/sgk/5991138
  set ambiwidth=double "Use twice the width of ASCII characters for Multibyte
endif

set helplang=ja,en
set spelllang+=cjk
set title                          " 編集中のファイル名を表示
set ambiwidth=double               " 全角文字で幅が崩れないように調整する
set laststatus=2

set number nornu
set noshowmode
set nowrap
set colorcolumn=80
set noequalalways
set winheight=8

set cindent
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu wildmode=longest,full
set foldmethod=marker
set foldlevel=1
set display=lastline
set cmdheight=2
set pumheight=15

set formatoptions+=tcqM1ro
if v:version > 703 || v:version == 703 && has("patch541")
  " Delete comment character when joining commented lines
  set formatoptions+=j
endif

if v:version > 704 || v:version == 704 && has("patch786")
  " Allow to make no-eol files.
  set nofixeol
endif

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set list lcs=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:~
set fillchars=vert:\|
set belloff=cursor,error,insertmode
set t_vb=
" }}}

" Search: {{{
set smartcase
set wrapscan
set incsearch
set hlsearch

" Cscope: {{{
if has("cscope")
  if tkngue#util#executable("gtags-cscope")
    set cscopeprg=gtags-cscope
  endif

  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if tkngue#util#executable("gtags-cscope")
    if filereadable("GTAGS")
        cs add GTAGS
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
  endif
  set csverb
  nnoremap <Leader>n  :cscope find c <C-R><C-W><CR>
endif
"}}}


" }}}

" Editing: {{{

set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=usetab
set showmatch
set matchtime=1
set nrformats=bin,hex
set history=10000
set autoread
set updatetime=4000

" 対応括弧に'<'と'>'のペアを追加
set matchpairs+=<:>,「:」,“:”,『:』,【:】
set backspace=indent,eol,start

if !has('nvim')
  set ttimeout
  set ttimeoutlen=2000
endif

if has('nvim')
  set clipboard=unnamed
    if has('mac')
      " NOTE: Performance issue and only for MacOS Settings
      let g:clipboard = {
        \ 'name': 'pbcopy',
        \ 'copy': { '+': 'pbcopy', '*': 'pbcopy'},
        \ 'paste': { '+': 'pbpaste', '*': 'pbpaste'}
        \ }
    elseif has('windows') && tkngue#util#executable('win32yank')
      " See https://github.com/equalsraf/win32yank
      let g:clipboard = {
            \   'name': 'win32yank',
            \   'copy': {
            \      '+': 'win32yank -i',
            \      '*': 'win32yank -i',
            \    },
            \   'paste': {
            \      '+': 'win32yank -o --lf',
            \      '*': 'win32yank -o --lf',
            \   },
            \   'cache_enabled': 1,
            \ }
    endif
else
  if has('unnamedplus')
    set clipboard=unnamedplus,exclude:cons\|linux
  else
    set clipboard=unnamed
  endif
endif

if has("persistent_undo")
  set undodir=$HOME/.vim/.undodir
  set undofile
  set undolevels=1000

  if !isdirectory("$HOME/.vim/.undodir")
      call tkngue#util#mkdir(expand("$HOME/.vim/.swap"), 1)
  endif
endif

set noswapfile
" set directory=$HOME/.vim/.swap
" if !isdirectory("$HOME/.vim/.swap")
"     call tkngue#util#mkdir(expand("$HOME/.vim/.swap"), 1)
" endif
set writebackup
set backupdir=$HOME/.vim/.backup
set backupext=.old
if !isdirectory("$HOME/.vim/.backup")
    call tkngue#util#mkdir(expand("$HOME/.vim/.backup"), 1)
endif
set backup
"}}}

" Mappings: {{{

let mapleader=","
let maplocalleader='\'

nnoremap Q <nop>
nnoremap C  "_C
nnoremap G  Gzv

"For Breaking off undo sequence.
inoremap <CR> <C-g>u<CR>
inoremap <C-h> <C-g>u<C-h>
inoremap <BS> <C-g>u<BS>
inoremap <Del> <C-g>u<Del>
inoremap <C-D> <C-g>u<Del>
inoremap <C-W> <C-g>u<C-w>
inoremap <C-U> <C-g>u<C-U>

nnoremap Y y$
vnoremap v $h

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nnoremap g; g;zOzz
nnoremap g, g,zOzz

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap * *N
nnoremap # #N
nnoremap n nzz
nnoremap N Nzz
nnoremap g* g*N
nnoremap g# g#N

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <C-W><C-z> :call tkngue#util#toggle_windowsize()<CR>
nnoremap <silent> <C-W>z :call tkngue#util#toggle_windowsize()<CR>

nnoremap <silent> <Space>o :call tkngue#util#open_folder_of_currentfile()<CR>

if has('gui_running')
  nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
  nnoremap <silent> <Space>.  :<C-u>e $MYVIMRC<CR>
endif

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() =~ '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <C-a>  <Home>

if has('nvim')
  tnoremap <Esc><Esc> <C-\><C-n>
endif


" Toggle: {{{
nnoremap [toggle] <Nop>
nmap <Leader>c [toggle]
nnoremap <silent> [toggle]s  :<C-u> setl spell!<CR>          : setl spell?<CR>
nnoremap <silent> [toggle]l  :<C-u> setl list!<CR>           : setl list?<CR>
nnoremap <silent> [toggle]t  :<C-u> setl expandtab!<CR>      : setl expandtab?<CR>
nnoremap <silent> [toggle]w  :<C-u> setl wrap!<CR>           : setl wrap?<CR>
nnoremap <silent> [toggle]z  :<C-u> setl lazyredraw!<CR>     : setl lazyredraw?<CR>
nnoremap <silent> [toggle]cc : setl cursorline!<CR>     : setl cursorline?<CR>
nnoremap <silent> [toggle]cr : setl cursorcolumn!<CR>   : setl cursorcolumn?<CR>
nnoremap <silent> [toggle]n  :<C-u> call tkngue#util#toggle_line_numbers()<CR>
nnoremap <silent> [toggle]p  :<C-u> set paste!<CR>
nnoremap <silent> [toggle]b  :<C-u> set binary!<CR> :
nnoremap <silent> [toggle]m  :<C-u>let &mouse = (&mouse == 'a' ? '' : 'a')<CR>:set mouse?<CR>
nnoremap <silent> [toggle]v  :<c-u>
      \:if &completeopt =~ 'preview'<CR>
      \:  set completeopt-=preview <CR> :pclose<CR>
      \:else<CR>
      \:  set completeopt+=preview <CR>
      \:endif<CR> :setl completeopt?<CR>
nnoremap <silent> [toggle]e :if(&colorcolumn > 0)<CR>
      \: setl colorcolumn=0<CR>
      \: else<CR> : setl colorcolumn=80<CR> : endif<CR>
" }}}
"
" Tab: {{{

" The prefix key.
nnoremap    [Tab]   <Nop>
nmap    <Leader>t   [Tab]

" tc 新しいタブを一番右に作る
nnoremap <silent> [Tab]c :tabnew<CR>
nnoremap <silent> [Tab]x :tabclose<CR>

" }}}

" Abbreviations: {{{
"自動で括弧内に移動
inoremap {} {}<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap <> <><left>
inoremap '' ''<left>
inoremap `` ``<left>
inoremap "" ""<left>
inoremap 「」 「」<left>
inoremap 【】 【】<left>
inoremap ”” “" <left>

inoremap {}<CR> {}
inoremap ()<CR> ()
inoremap []<CR> []

inoremap {}<space> {}
inoremap ()<space> ()
inoremap []<space> []

"}}}
"}}}
;
"Highlight: {{{
augroup my_higlight
  autocmd!
  autocmd ColorScheme * call s:additional_highlight()
augroup END

function! s:additional_highlight() "{{{
  if !has('gui_running')
    highlight Normal ctermbg=none
  endif
  highlight MatchParen term=inverse cterm=bold ctermfg=208 ctermbg=233 gui=bold guifg=#000000 guibg=#FD971F
  highlight CursorLine cterm=bold ctermfg=lightcyan ctermbg=None gui=bold
  highlight IncSearch cterm=bold ctermfg=green ctermbg=None gui=bold
  highlight Search cterm=bold ctermfg=green ctermbg=None gui=bold
  " highlight Normal ctermbg=none
  " highlight IncSearch Search cterm=bold ctermfg=green ctermbg=None gui=bold
  " highlight Visual cterm=bold ctermfg=red ctermbg=None guibg=#403D3D
  " echomsg 'called adiitoinal highlight'
endfunction "}}}



"}}}

" Misc: {{{
if has('nvim')
  set shada=
  " set shada=!,'50,<50,s10,h,:100,n/tmp/rdisk/nvim.shda,/20,
  augroup user_shada
      autocmd!
      autocmd VimEnter * rshada ~/.local/share/nvim/shada/main.shada
      autocmd VimEnter * set shada=!,'500,<50,s10,h
  augroup END
endif

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %
" Open junk file
command! -nargs=? -complete=filetype Memo
            \ call tkngue#util#open_junk_file('<args>')
" Todoコマンド
command! Todo call tkngue#util#open_todofile()
command! -bang -nargs=* PluginTest
            \ call tkngue#util#test_plugin(<bang>0, <q-args>)
command! FollowSymlink  call tkngue#util#switch_to_actualfile()
command! -nargs=1 Wget call tkngue#util#load_webpage(<q-args>)
command! -nargs=1 DiffRev call tkngue#util#get_diff_files(<q-args>)

" after/ftpluginの作成 User設定のfiletype plugin
let g:ftpPath = $HOME . "/.vim/after/ftplugin/"
nnoremap <silent>  <Space>, :<C-u>call <SID>openFTPluginFile()<CR>
function! s:openFTPluginFile()
  let l:ftpFileName = g:ftpPath . &filetype . ".vim"
  execute 'botright vsplit ' . l:ftpFileName
endfunction


function! s:cd_project_dir() abort
  let [l:path, l:lang, _] = tkngue#util#detect_project()
  if isdirectory(l:path)
    echomsg "AutoCD: " . l:path 
    exec "lcd " . l:path
  endif
endfunction

function! s:my_on_filetype() abort "{{{
  if &l:filetype == '' && bufname('%') == ''
    return
  endif

 if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    filetype detect
    syntax enable
    " redraw!
    call s:additional_highlight()
  endif
endfunction "}}}

augroup office_format "{{{
  autocmd!
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}
          \ set modifiable |
          \ if tkngue#util#executable('tika') |
          \   silent %d |  silent %read !tika --text %:p |
          \ endif |
          \ set readonly normal gg
augroup END "}}}

augroup TerminalSetting "{{{
  autocmd!
  autocmd TermOpen *
        \ setl nonumber
  autocmd TermOpen term://* startinsert
augroup END "}}}


augroup binaryfile "{{{
  autocmd!
  au BufRead * if tkngue#util#is_binary() | setl binary | %!xxd
  au BufRead * set ft=xxd | endif
  au BufWritePre * if &bin | %!xxd -r
  au BufWritePre * endif
  au BufWritePost * if &bin | %!xxd
  au BufWritePost * set nomod | endif
augroup END "}}}

augroup edit_vimrc "{{{
  autocmd!
  " autocmd BufReadPost $MYVIMRC setlocal path+=$HOME/.vim/bundle
  autocmd BufRead bundles.toml execute "setlocal path+=" . substitute(glob(s:cache_home . "/repos/*"), '\n', ',', 'g')
  " autocmd BufReadPost bundles.toml execute "setlocal tags+=" . substitute(glob(s:cache_home . "/repos/*"), '\n', ',', 'g')
  autocmd BufReadPost $MYVIMRC execute "setlocal tags+=" . substitute(glob("$HOME/.vim/bundle/**/.git/tags"), '\n', ',', 'g')
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd BufWritePost bundles.toml source $MYVIMRC
  autocmd BufWritePost ~/.dotfiles/.vimrc nested source $MYVIMRC
augroup END "}}}

if tkngue#util#executable("ghq")
    let s:ghq_path = tkngue#util#system("ghq root")
    execute "set path+=" . substitute(glob(s:ghq_path . "/*"), '\n', ',', 'g')
endif

augroup MyAutocmdGroup "{{{
  autocmd!
  autocmd BufNewFile,BufRead *.todo
        \ set nonumber norelativenumber filetype=markdown
  " diff
  autocmd  InsertLeave *
        \ if &diff | diffupdate | echo 'diff updated' | endif
  " large_file_config_for_smooth
  autocmd BufNewFile,BufRead * if &filetype != 'help' && line('$') > 10000 |
        \   setl nonumber norelativenumber nocursorline|
        \   filetype plugin indent off |
        \   setl syntax=off |
        \ endif

  autocmd BufWritePre * call tkngue#util#mkdir(expand('<afile>:p:h'), v:cmdbang)
  autocmd QuickfixCmdPost make,diff,grep,grepadd,vimgrep,vimdiff copen
  autocmd CmdwinEnter * nnoremap <buffer>q  <C-w>c
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  autocmd BufNewFile,BufRead *.ipynb set filetype=json
  autocmd BufNewFile,BufRead *.gs set filetype=javascript
  " autocmd BufReadPost * call s:SwitchToActualFile()
  autocmd FileType sh,zsh,csh,tcsh let &l:path = substitute($PATH, ':', ',', 'g')
  autocmd BufWinEnter * call tkngue#util#restore_curosr_position()

  " help, quickfix settings
  autocmd FileType help,qf nnoremap <buffer> q <C-w>c
  autocmd FileType help nnoremap <buffer> <CR>  <C-]>
  autocmd FileType help nnoremap <buffer> <BS>  <C-o>

  " MEMO: Shdo するさいに lcdしてしまうのがうざいのでdisabled
  " autocmd BufRead * call s:cd_project_dir()
  autocmd VimEnter * if filereadable(expand("./.vimrc.local"))
      \ | execute 'source ' . expand("./.vimrc.local")
      \ | endif
  autocmd DirChanged * if filereadable(expand("<afile>/.vimrc.local"))
        \ | execute 'source ' . expand("<afile>/.vimrc.local")
        \ | endif

  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *
        \ call s:my_on_filetype()

augroup END
"}}}

"}}}

"}}}
"
" Plugin Settings ============== {{{

" Standard Vim plugins {{{
let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
" let g:loaded_gzip              = 1
" let g:loaded_man               = 1
" let g:loaded_matchit           = 1
" let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 0
let g:loaded_netrwPlugin       = 0
" let g:loaded_netrwSettings     = 1
" let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
" let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
" let g:loaded_zipPlugin         = 1

"}}}

" dein.vim Initilization {{{
let g:noplugin = &compatible ? 1 : 0
if !g:noplugin
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  let s:cache_home = s:cache_home . '/dein'

  " Load dein.
  let s:dein_dir = finddir('dein.vim', '.;')
  let s:dein_repo = expand(s:cache_home) . '/repos/github.com/Shougo/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo
    endif
  endif
  execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_repo, ':p') , '/$', '', '')

  if dein#load_state(s:cache_home)
      call dein#begin(s:cache_home)
      call dein#load_toml('~/.vim/bundles.toml')
      call dein#end()
      call dein#save_state()
  endif

  if !has('vim_starting') && dein#check_install()
      " Installation check.
      call dein#install()
  endif
endif

" END dein}}}


"}}}

" Local settings ================ {{{
let s:local_vimrc = expand('~/.local.vimrc')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif
" }}}

" Finally ======================={{{
"
" Colorscheme: {{{
" Check color
" :so $VIMRUNTIME/syntax/colortest.vim
" Check syntax
" :so $VIMRUNTIME/syntax/hitest.vim
if has('gui_running')
    colorscheme PaperColor
elseif has('vim_starting')
    set background=dark
    if &t_Co < 256
        colorscheme default
    else
        try
            colorscheme molokai
        catch
            colorscheme blue
        endtry
    endif
endif
"}}}

if has('vim_starting')
    set t_Co=256
    syntax sync minlines=512
    filetype plugin indent off
    syntax off
else
  " THIS IS NOT BAD HACK
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif

"}}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker number nornu
