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
    autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
          \ | echomsg 'startuptime:' . reltimestr(g:startuptime)
  augroup END
endif
" }}}
" ====================== }}}

" Vim Setup ===================== {{{
"System Settings: {{{
if has('nvim')
  let g:python3_host_prog = $PYENV_ROOT . '/versions/vim_dev3/bin/python3'
  " if !executable(g:python3_host_prog)
  "     let g:python3_host_prog  = system('which python3')
  " endif
  let g:python_host_prog = g:python3_host_prog
elseif has('gui_macvim')
   set pythondll=
   set pythonthreedll=/Users/alrescha/.zplug/repos/riywo/anyenv/envs/pyenv/versions/3.5.1/Python.framework/Versions/3.5/Python
   let s:python_path = split(system('pyenv prefix vim_dev3'), '\n')[0] .  '/lib/python3.5/site-packages'
python <<EOM
python_path = vim.eval('s:python_path')
sys.path.insert(0, python_path)
sys.path.insert(0, "/Users/alrescha/.zplug/repos/riywo/anyenv/envs/pyenv/versions/3.5.1/Python.framework/Versions/3.5/Python")
EOM
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
set nowrap
set textwidth=80
set colorcolumn=80
set cursorline
set noequalalways
set winheight=8

set cindent
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu wildmode=longest,full
set foldmethod=marker
set display=lastline
set cmdheight=2
set pumheight=15

if v:version > 703 || v:version == 703 && has("patch541")
  " Delete comment character when joining commented lines
  set formatoptions+=j
endif

if v:version > 704 || v:version == 704 && has("patch786")
  " Allow to make no-eol files.
  set nofixeol
endif

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set list lcs=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:⏎
set fillchars=vert:\|
set belloff=cursor,error,insertmode
set t_vb=
" }}}

" Search: {{{
set smartcase
set wrapscan
set incsearch
set hlsearch
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
set updatetime=300

" 対応括弧に'<'と'>'のペアを追加
set matchpairs+=<:>,「:」,“:”,『:』,【:】
set backspace=indent,eol,start

if !has('nvim')
  set ttimeout
  set ttimeoutlen=2000
endif

if has('nvim')
  set clipboard=unnamedplus
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
endif

set swapfile
set directory=$HOME/.vim/.swap
set directory=~/.vim/.swap
set writebackup
set backupdir=$HOME/.vim/.backup
set nobackup
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
nnoremap & g&
nnoremap & g&
vnoremap v $h

nnoremap z& :<C-u>spellr<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nnoremap g; g;zOzz
nnoremap g, g,zOzz

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap * *N
nnoremap # #N
nnoremap n nzz
nnoremap N Nzz
nnoremap g* g*Nzz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
vnoremap j gj
nnoremap gj j
vnoremap gj j

nnoremap k gk
vnoremap k gk
nnoremap gk k
vnoremap gk k


" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-W><C-z> :call ToggleWindowSize()<CR>
nnoremap <C-W>z :call ToggleWindowSize()<CR>

" nnoremap <silent> <Space>h  :<C-u>wincmd h<CR>
" nnoremap <silent> <Space>j  :<C-u>wincmd j<CR>
" nnoremap <silent> <Space>k  :<C-u>wincmd k<CR>
" nnoremap <silent> <Space>l  :<C-u>wincmd l<CR>

function! ToggleWindowSize()
  if !exists('t:restcmd')
    let t:restcmd = ''
  endif
  if t:restcmd  != ''
    exe t:restcmd
    let t:restcmd = ''
  else
    let t:restcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction

function! OpenFolderOfCurrentFile() abort
  let l:path = escape(expand("%:p:h"),' ()')
  if has('unix') && s:executable('xdg-open')
    call system( 'xdg-open '. path)
  elseif has('mac') && s:executable('open')
    call system('open '. path)
  endif
endfunction
nnoremap <Space>o :call OpenFolderOfCurrentFile()<CR>

if has('gui_running')
  nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
  nnoremap <silent> <Space>.  :<C-u>e $MYVIMRC<CR>
endif

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() =~ '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
cnoremap <expr> ; getcmdtype() == '/' ? '/;/' : ';'
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <C-a>  <Home>

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
nnoremap <silent> [toggle]n  :<C-u> call <SID>toggle_line_number()<CR>
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
function! s:toggle_line_number()
  if exists('+relativenumber')
    if (v:version >= 704)
      " Toggle between relative with absolute on cursor line and no numbers.
      let l:mapping = [[[0,1],[1,1]],[[1,1],[0,0]]]
      " let [&l:relativenumber, &l:number] =
      "       \ (&l:relativenumber || &l:number) ? [0, 0] : [1, 1]
      let [&l:relativenumber, &l:number] = l:mapping[&l:relativenumber][&l:number]
    else
      " Rotate absolute => relative => no numbers.
      execute 'setlocal' (&l:number == &l:relativenumber) ?
            \ 'number! number?' : 'relativenumber! relativenumber?'
    endif
  else
    setlocal number! number?
  endif
endfunction

" Tab: {{{
" The prefix key.
nnoremap    [Tab]   <Nop>
nmap    <Leader>t   [Tab]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
nnoremap <silent> [Tab]c :tabnew<CR>
nnoremap <silent> [Tab]x :tabclose<CR>
nnoremap <silent> gl :tabnext<CR>
nnoremap <silent> gh :tabprevious<CR>
nnoremap <silent> [Tab]l :call MoveBufferInNewTab()<CR>

function! MoveBufferInNewTab() abort
  execute "tabnew \| buffer ". eval(bufnr('%'))
endfunction

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
"}}}
"}}}

"Highlight: {{{
augroup my_higlight
  autocmd!
  autocmd ColorScheme * call s:additional_highlight()
  autocmd User VimrcReloaded call s:additional_highlight()
augroup END

function! s:additional_highlight() "{{{
  if !has('gui_running') && &bg == 'dark'
    highlight Normal ctermbg=none
  endif
  highlight MatchParen term=inverse cterm=bold ctermfg=208 ctermbg=233 gui=bold guifg=#000000 guibg=#FD971F
  " highlight CursorLine cterm=bold ctermbg=darkcyan gui=bold
endfunction "}}}
"}}}

" Misc: {{{
" Cached executable "{{{
let s:_executable = {}
function! s:executable(expr) "{{{
  let s:_executable[a:expr] = has_key(s:_executable, a:expr) ?
        \ s:_executable[a:expr] : executable(a:expr)
  return s:_executable[a:expr]
endfunction "}}}
"}}}

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" augroup update_autocmd
"   autocmd!
"   autocmd  BufEnter * checktime
  autocmd  WinEnter * checktime
" augroup END

augroup my_diff_autocmd
  autocmd!
  autocmd  InsertLeave *
        \ if &diff | diffupdate | echo 'diff updated' | endif
augroup END

" Open junk file:{{{
command! -nargs=? -complete=filetype Memo call s:open_junk_file('<args>')
function! s:open_junk_file(type)
  " execute "%d a"
  let l:junk_dir = $HOME . '/Dropbox/junks'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif
  if a:type == ''
    let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  else
    let l:filename = l:junk_dir . strftime('/%Y-%m-%d-%H%M%S.') . a:type
  endif
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction "}}}

" TODOコマンド
command! Todo call s:Todo() " Todoコマンド
function! s:Todo() "{{{
  let l:path  =  "~/.todo"
  if filereadable(expand("~/Dropbox/.todo"))
    let l:path = expand("~/Dropbox/.todo")
  endif
  if bufwinnr(l:path) < 0
    execute 'silent bo 60vs +set\ nonumber ' . l:path
  endif
  unlet! l:path
endfunction "}}}

command! -bang -nargs=* PluginTest call PluginTest(<bang>0, <q-args>)
function! PluginTest(is_gui, extraCommand)
  let cmd = a:is_gui ? 'gvim' : 'vim'
  let extraCommand = escape(a:extraCommand, '!\<>"')
  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * nested ' . extraCommand . '"'
  if exists('b:git_dir')
    let l:additional_path = shellescape(fnamemodify(b:git_dir, ':p:h:h'))
  else
    let l:additional_path = shellescape(fnamemodify(getcwd(), ':p:h:h'))
  endif
  execute '!' . cmd . ' -u ~/.min.vimrc -i NONE -N --cmd "set rtp+=' . additional_path . '"' . extraCommand
endfunction
"
augroup edit_memo
  autocmd!
  autocmd BufNewFile,BufRead *.todo
        \ set nonumber norelativenumber filetype=markdown
  autocmd BufNewFile,BufRead *.memo
        \ set nonumber norelativenumber filetype=markdown
augroup END

augroup large_file_config_for_smooth
  autocmd!
  autocmd BufNewFile,BufRead * if line('$') > 2000 |
        \   set nonumber norelativenumber nocursorline |
        \ endif
augroup END

" after/ftpluginの作成 User設定のfiletype plugin
let g:ftpPath = $HOME . "/.vim/after/ftplugin/"
nnoremap <silent>  <Space>, :<C-u>call <SID>openFTPluginFile()<CR>
function! s:openFTPluginFile()
  let l:ftpFileName = g:ftpPath . &filetype . ".vim"
  execute 'botright vsplit ' . l:ftpFileName
endfunction

function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    execute 'lcd ' . escape(expand('%:p:h'), ' ()')
  else
    execute 'lcd ' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

if s:executable('tika')
  augroup office_format "{{{
    autocmd!
    autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}
          \ set modifiable | 
          \ silent %d |  silent %read !tika --text %:p | 
          \ set readonly normal gg
  augroup END "}}}
endif

function! s:SwitchToActualFile()
  let l:fname = resolve(expand('%:p'))
  let l:pos = getpos('.')
  let l:bufname = bufname('%')
  enew
  exec 'bw '. l:bufname
  exec "e" . fname
  call setpos('.', pos)
endfunction "}}}

command! FollowSymlink  call s:SwitchToActualFile()

function! Load_webpage(url) abort
  execute 'r !wget -O - '.a:url.' 2>/dev/null'
endfunction
command! -nargs=1 Wget call Load_webpage(<q-args>)

function! s:RestoreCursorPostion() "{{{
  let ignore_filetypes = ['gitcommit']
  if index(ignore_filetypes, &l:filetype) >= 0
    return
  endif

  if line("'\"") > 1 && line("'\"") <= line("$")
    execute 'normal! g`"'
  endif
  try
    normal! zMzvzz
  catch /E490/
  endtry
endfunction "}}}

augroup MyAutoCmd " {{{
  autocmd!
  "autocmd VimEnter * call s:ChangeCurrentDir('', '')
  autocmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
  autocmd QuickfixCmdPost make,diff,grep,grepadd,vimgrep,vimdiff copen
  autocmd FileType help,qf nnoremap <buffer> q <C-w>c
  autocmd CmdwinEnter * nnoremap <buffer>q  <C-w>c
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  " autocmd BufReadPost * call s:SwitchToActualFile()
  autocmd FileType sh,zsh,csh,tcsh let &l:path = substitute($PATH, ':', ',', 'g')
  autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END " }}}

augroup vimrc_change_cursorline_color "{{{
  autocmd!
  " " インサートモードに入った時にカーソル行の色をブルーグリーンにする
  " autocmd InsertEnter * highlight CursorLine ctermbg=23 guibg=yellow
  " autocmd InsertEnter * highlight CursorColumn ctermbg=24 guibg=#005f87
  " " インサートモードを抜けた時にカーソル行の色を黒に近いダークグレーにする
  " autocmd InsertLeave * highlight CursorLine ctermbg=236 guibg=#303030
  " autocmd InsertLeave * highlight CursorColumn ctermbg=236 guibg=#303030
augroup END "}}}

augroup edit_vimrc "{{{
  autocmd!
  " autocmd BufReadPost $MYVIMRC setlocal path+=$HOME/.vim/bundle
  autocmd BufReadPost $MYVIMRC execute "setlocal tags+=" . substitute(glob("$HOME/.vim/bundle/*/.git/tags"), '\n', ',', 'g')
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END "}}}

augroup help_setting
  autocmd!
  autocmd FileType help nnoremap <buffer> <CR>  <C-]>
  autocmd FileType help nnoremap <buffer> <BS>  <C-o>
augroup END
"}}}

"}}}

" Plugin Settings ============== {{{

" dein.vim Initilization {{{
let g:noplugin = 0

" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  let $CACHE = expand('~/.cache')
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute ' set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')

endif

let s:dein_dir = expand('$CACHE/dein')
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml('~/.vim/bundles.toml')
    if dein#tap('deoplete.nvim') && has('nvim')
     call dein#disable('neocomplete.vim')
    endif
    call dein#end()
    call dein#save_state()
endif

if dein#check_install() && !has('vim_starting') 
    " Installation check.
    call dein#install()
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

if has('vim_starting')
    set t_Co=256
    let g:solarized_termcolors=256

    " Colorscheme: {{{
    " Check color
    " :so $VIMRUNTIME/syntax/colortest.vim
    " Check syntax
    " :so $VIMRUNTIME/syntax/hitest.vim
    "
    if has('gui_running')
        colorscheme PaperColor
    else
        set background=light
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

    call dein#call_hook('on_source')
    call dein#call_hook('on_post_source')

    syntax on
    filetype plugin indent on
    syntax sync minlines=512
endif


"}}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker number nornu
