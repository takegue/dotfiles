" Author: TKNGUE
" URL: https://github.com/TKNGUE/dotfiles
" Description:
"   This is TKNGUE's vimrc
"   For quickly access, you should use 

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

" NeoBundle {{{
let g:noplugin = 0
let g:bundle_root=  has('win32') || has('win64') ?
      \ expand('~/vimfiles/bundle') : expand('~/.vim/bundle')
let g:neobundle_root = g:bundle_root . '/neobundle.vim'

if !isdirectory(g:neobundle_root)
  echon 'Installing neobundle.vim...'
  if !isdirectory(g:bundle_root) 
    silent call mkdir(g:bundle_root, 'p')
  endif
  execute "silent !git clone https://github.com/Shougo/neobundle.vim ". g:neobundle_root
  echo 'done.'
  if v:shell_error
    echoerr 'neobundle.vim installation has failed!'
    finish
  endif
endif

if has('vim_starting')
  execute "set runtimepath+=" . g:neobundle_root
endif

call neobundle#begin(g:bundle_root)
function! s:loads_bundles() abort "{{{
  NeoBundleFetch 'Shougo/neobundle.vim'                    " Manage neobundle.vim itself

  " =====
  " NeoBundle User Settings
  " =====
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'tpope/sensible.vim'
  "BUNDLE_ENDPOINT

endfunction "}}}

if !g:noplugin && neobundle#load_cache()
  call s:loads_bundles()
endif
call neobundle#end()

NeoBundleCheck
" END NeoBundle}}}

" ====================== }}}

" Vim Setup ===================== {{{
" Basic Settings: {{{

" Encodings: {{{
set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp "A list of character encodings
set fileformats=unix,dos,mac "This gives the end-of-line (<EOL>) formats
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

set lazyredraw
set helplang=ja,en
set spelllang+=cjk
set title                          " 編集中のファイル名を表示
set ambiwidth=double               " 全角文字で幅が崩れないように調整する
set laststatus=2

set number                         " 行番号の表示
set relativenumber                 " 相対行番号の表示
set nowrap                         " 長いテキストの折り返し
set textwidth=0                    " 自動的に改行が入るのを無効化
set colorcolumn=80                 " その代わり80文字目にラインを入れる
set cursorline                     " 編集中の行のハイライト

set smartindent                    " オートインデント
" set autoindent
set cindent
set tabstop=8
set shiftwidth=4                   " オートインデントの幅
set softtabstop=4                  " インデントをスペース4つ分に設定
set expandtab                      " タブ→スペースの変換
set wildmenu wildmode=longest,full " コマンドラインの補間表示
set foldmethod=marker
set display=lastline
set cmdheight=2                    " To suppress '<Press Enter>'
set pumheight=15

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j             " Delete comment character when joining commented lines
endif

if v:version > 704 || v:version == 704 && has("patch786")
  set nofixeol                    " Allow to make no-eol files. 
endif

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set list lcs=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:⏎ "
set fillchars=vert:\|

set t_vb=
set novisualbell

" }}}

" Search: {{{
set smartcase           "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan            "検索時に最後まで行ったら最初に戻る
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" }}}

" Editing: {{{

set shiftround              " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase               " 補完時に大文字小文字を区別しない
set virtualedit=all         " カーソルを文字が存在しない部分でも動けるようにする
set hidden                  " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=usetab       " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch               " 対応する括弧などをハイライト表示する
set matchtime=1             " 対応括弧のハイライト表示を3秒にする
set nrformats=hex
set history=10000           " ヒストリ機能を10000件まで有効にする
set autoread                " Automatically reload change files on disk
set updatetime=2000         " Automatically reload change files on disk

set ttimeout
set ttimeoutlen=100

if has('unnamedplus') && !(has("win32") || has("win64"))
  set clipboard=unnamedplus,autoselect
else
  set clipboard=unnamed
endif


if has("persistent_undo")
  set undodir='~/.vim/.undodir'
  set undofile
  set undolevels=1000
endif


" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

set nowritebackup
set nobackup
set noswapfile

" }}}
"}}}

" Mappings: {{{

let mapleader=','                                "map learder
let maplocalleader='\'                           "local map leader

" inoremap jj <Esc>
" nnoremap ; q:a
" nnoremap ; :
" nnoremap : q:i
" nnoremap Q q
" nnoremap q <Nop>
nnoremap Q <nop>
" nnoremap q: q:
nnoremap c  "_c
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

"
nnoremap Y y$
nnoremap & g&

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc>    :noh<CR>

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


" vを二回で行末まで選択
vnoremap v $h

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

nnoremap <silent><C-F> :<C-U>setl lazyredraw<CR><C-D><C-D>:setl nolazyredraw<CR>
nnoremap <silent><C-B> :<C-U>setl lazyredraw<CR><C-U><C-U>:setl nolazyredraw<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

nnoremap <Left>     <Nop>
nnoremap <Right>    <Nop>
nnoremap <Up>       <Nop>
nnoremap <Down>       <Nop>

nnoremap <C-Left>     <Nop>
nnoremap <C-Right>    <Nop>
nnoremap <C-Up>       <Nop>
nnoremap <C-Down>     <Nop>
"
if has('gui_running')
  nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
  nnoremap <silent> <Space>.  :<C-u>e $MYVIMRC<CR>
endif

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
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

function! s:toggle_line_number()
  if exists('+relativenumber')
    if (v:version >= 704)
      " Toggle between relative with absolute on cursor line and no numbers.
      let [&l:relativenumber, &l:number] =
            \ (&l:relativenumber || &l:number) ? [0, 0] : [1, 1]
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

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
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

" Fold: {{{
noremap [fold] <nop>
nmap <Space> [fold]
vmap <Space> [fold]

noremap [fold]j zj
noremap [fold]k zk
noremap [fold]n ]z
noremap [fold]p [z
noremap [fold]l zo
noremap [fold]L zO
noremap [fold]a za
noremap [fold]m zM
noremap [fold]i zMzvzz
noremap [fold]r zR
noremap [fold]f zf
noremap [fold]d zd

nnoremap <expr>l  foldclosed('.') != -1 ? 'zo' : 'l'

nnoremap  [fold][     :<C-u>call <SID>put_foldmarker(0)<CR>
"}}}

" Abbreviations: {{{
"自動で括弧内に移動
inoremap {} {}<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap <> <><left>
inoremap '' ''<left>
inoremap `` ``<left>
inoremap "" ""<left>

"}}}
"}}}

"Highlight: {{{
augroup my_higlight
  autocmd!
  autocmd ColorScheme * call s:additional_highlight()
  autocmd User VimrcReloaded call s:additional_highlight()
augroup END

function! s:additional_highlight() "{{{
  if !has('gui_running')
    " highlight Normal ctermbg=none
  endif
  highlight MatchParen term=inverse cterm=bold ctermfg=208 ctermbg=233 gui=bold guifg=#000000 guibg=#FD971F
endfunction "}}}
"}}}

" Colorscheme: {{{
" Check color
" :so $VIMRUNTIME/syntax/colortest.vim
" Check syntax
" :so $VIMRUNTIME/syntax/hitest.vim

if has('vim_starting')
  syntax on
  set t_Co=256
  let g:solarized_termcolors=256

  if has('gui_running')
    colorscheme PaperColor
  else
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
  " ファイルタイププラグインおよびインデントを有効化
  " これはNeoBundleによる処理が終了したあとに呼ばなければならない
endif
"}}}

"}}}

" Plugin Settings ============== {{{
" Unite Settings: {{{
" Shougo/unite:vim {{{
if neobundle#tap('unite.vim')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'commands' : [
        \       {
        \         'name' : 'Unite',
        \         'complete' : 'customlist,unite#complete_source'
        \       },
        \       'UniteWithCursorWord',
        \       'UniteWithInput'
        \     ]
        \   }
        \ }) "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    nnoremap [unite]    <Nop>
    nmap    <Leader>f  [unite]
    nnoremap  [unite]s  :<C-u>Unite source<CR>
    nnoremap  [unite]f  :<C-u>Unite -buffer-name=files -no-split
          \ bookmark buffer file_rec/git file file_mru 
          \ file/new directory/new <CR>
    nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files 
          \ buffer bookmark file
          \ file_rec/async:! file
          \ file/new directory/new <CR>
    nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
          \ -buffer-name=files -prompt=%\  buffer bookmark file<CR>
    nnoremap <silent> [unite]r  :<C-u>Unite
          \ -buffer-name=register register<CR>
    nnoremap <silent> [unite]o  :<C-u>Unite outline tag
          \ -buffer-name=outline <CR>
    nnoremap <silent> [unite]n  :<C-u>Unite 
          \ -buffer-name=bundles
          \ neobundle/search <CR>
    nnoremap <silent> [unite]s  :<C-u>Unite 
          \ -buffer-name=snippets
          \ neosnippet <CR>
    nnoremap <silent> [unite]ma :<C-u>Unite mapping
          \ -buffer-name=mapping <CR>
    nnoremap <silent> [unite]me :<C-u>Unite output:message
          \ -buffer-name=messages <CR>
    " nnoremap <silent> [unite]b  :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]a  :<C-u>UniteBookmarkAdd<CR>

    nnoremap <silent> [unite]gf :<C-u>Unite -buffer-name=search-buffer grep:%<CR>
    nnoremap <silent> [unite]gg :<C-u>Unite -buffer-name=search-buffer grep:./:-iR<CR>
    nnoremap <silent> [unite]gc :<C-u>Unite -buffer-name=search-buffer grep:$buffers::<C-R><C-W><CR>
    nnoremap <silent> [unite]R  :<C-u>Unite -buffer-name=resume resume<CR>
    nnoremap <silent> [unite]h  :<C-u>Unite -buffer-name=help help<CR>
    nnoremap <silent> [unite]z :<C-u>Unite -silent fold -vertical -winwidth=40 -no-start-insert<CR>
    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord -buffer-name=help help<CR>

  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    call unite#custom#profile('default', 'context', {
          \   'start_insert': 1,
          \   'prompt': '» ',
          \ })
  endfunction "}}}

  " Setting {{{

  " Start insert.
  let g:unite_source_history_yank_save_clipboard = 0
  let g:unite_redraw_hold_candidates = 50000
  let g:unite_source_file_rec_max_cache_files = 50000

  " Like ctrlp.vim settings.
  "call unite#custom#profile('default', 'context', {
  "\   'start_insert': 1,
  "\   'winheight': 10,
  "\   'direction': 'botright',
  "\ })


  autocmd FileType unite call s:unite_my_settings()

  function! s:unite_my_settings() "{{{
    " Overwrite settings.
    imap <buffer> jj      <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    imap <buffer><expr> j unite#smart_map('j', '')
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    " nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    nnoremap <silent><buffer><expr> l
          \ unite#smart_map('l', unite#do_action('default'))

    let unite = unite#get_current_unite()
    if unite.profile_name ==# 'search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
    nnoremap <buffer><expr>S      unite#mappings#set_current_sorters(
          \ empty(unite#mappings#get_current_sorters()) ?
          \ ['sorter_reverse'] : [])
    nnoremap <buffer><expr>M    unite#mappings#set_current_matchers(
          \ empty(unite#mappings#get_current_matchers()) ?
          \ ['matcher_migemo'] : [])
    nnoremap <buffer><expr>R    unite#mappings#set_current_matchers(
          \ empty(unite#mappings#get_current_matchers()) ?
          \ ['matcher_regexp'] : [])

    " Runs "split" action by <C-s>.
    imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  endfunction "}}}

  " mappingが競合するためデフォルトマッピング無効
  " let g:unite_no_default_keymappings = 1
  " nnoremap <silent> <Plug>(unite_exit)

  " unite grep に ag(The Silver Searcher) を使う
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command ='ag --follow --nocolor --nogroup --hidden -g ""'
  endif
  "}}}
  "
  call neobundle#untap()
endif
" }}} "

" Shougo/vimfiler.vim {{{
if neobundle#tap('vimfiler.vim')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \ "autoload": {
        \   "commands": [
        \       { 'name' : 'VimFiler',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerTab',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerBufferDir',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'VimFilerExplorer',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'Edit',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       { 'name' : 'Write',
        \         'complete' : 'customlist,vimfiler#complete' },
        \       'Read', 'Source'
        \       ],
        \   "mappings" : '<Plug>(vimfiler_' ,
        \   "explorer": 1,
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    call vimfiler#set_execute_file('txt', 'notepad')
    call vimfiler#set_execute_file('c', ['gvim', 'notepad'])
    call vimfiler#custom#profile('default', 'auto-cd', 'lcd')
  endfunction "}}}

  " vimfiler specific key mappings {{{
  function! s:vimfiler_settings()
    " ^^ to go up 
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
    nmap <buffer> <C-j> <C-w>j
  endfunction " }}}

  function! VimFilerExplorerWithLCD() abort
    execute "VimFilerExplorer ". expand('%:p:h')
  endfunction

  " Setting {{{
  nnoremap <silent><Leader>e :call VimFilerExplorerWithLCD()<CR>
  nnoremap <silent><Leader>E :VimFiler<CR>

  augroup vimfile_options
    " this one is which you're most likely to use?
    autocmd FileType vimfiler call <SID>vimfiler_settings()
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  augroup END

  let g:loaded_netrwPlugin = 1
  let g:vimfiler_ignore_pattern = '\(\.git\|\.DS_Store\|.py[co]\|\%^\..\+\)\%$'
  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = ' '
  let g:vimfiler_marked_file_icon = '*'
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_as_default_explorer = 1
  let g:unite_kind_openable_lcd_command='lcd'
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_split_rule="botright"
  "}}}

  call neobundle#untap()
endif
"}}}

" Shougo/unite-outline {{{
if neobundle#tap('unite-outline')
  " Config {{{
  call neobundle#config( {
        \ "depends": ["Shougo/unite.vim"],
        \ })
  "}}}

  " Setting {{{
  nnoremap <silent> <Leader>o :<C-u>botright Unite -vertical -no-quit -winwidth=40 -direction=botright outline<CR> 
  "}}}

  call neobundle#untap()
endif
" }}} "

" tsukkee/unite-tag {{{
if neobundle#tap('unite-tag')
  " Config {{{
  call neobundle#config( {
        \ "depends": ["Shougo/unite.vim"],
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    autocmd BufEnter *
          \   if empty(&buftype)
    " \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
          \|  endif
    call neobundle#untap()
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" ujihisa/unite-colorscheme {{{
if neobundle#tap('unite-colorscheme')
  " Config {{{
  call neobundle#config( {
        \ "depends": ["Shougo/unite.vim"],
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" Shougo/neomru.vim {{{
if neobundle#tap('neomru.vim')
  " Config {{{
  call neobundle#config( {
        \ "depends": ["Shougo/unite.vim"],
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:neomru#do_validate = 1

  let g:neomru#file_mru_ignore_pattern = 
        \'\~$\|\.\%(o\|exe\|dll\|bak\|zwc\|pyc\|sw[po]\)$'.
        \'\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
        \'\|^\%(\\\\\|/mnt/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'.
        \'\|\%(^\%(fugitive\)://\)'
  "}}}

  call neobundle#untap()
endif
" }}} "

" tsukkee/unite-help {{{
if neobundle#tap('unite-help')
  " Config {{{
  call neobundle#config( {
        \ "depends": ["Shougo/unite.vim"],
        \ })
  "}}}

  call neobundle#untap()
endif
" }}} "

" Shougo/neossh.vim {{{
if neobundle#tap('neossh.vim')
  " Config {{{
  call neobundle#config( {
        \ "depends": ['Shougo/unite.vim']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" mattn/unite-advent_calendar {{{
if neobundle#tap('unite-advent_calendar')
  " Config {{{
  call neobundle#config( {
        \ "depends": ['Shougo/unite.vim','tyru/open-browser.vim', 'mattn/webapi-vim'],
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:calendar_frame = 'default'
  "}}}

  call neobundle#untap()
endif
" }}} "

" }}}

" PLUGIN_SETTING_ENDPOINT
filetype plugin indent on
" }}}


" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
