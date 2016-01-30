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

  " For author/plugin-name sort
  " :!sort -k2fd
  " For plugin-name/author sort
  " :!sort -k2fd -t/
  NeoBundle 'alfredodeza/pytest.vim'
  NeoBundle 'AndrewRadev/switch.vim'
  NeoBundle 'basyura/unite-rails'                          " a unite.vim plugin for rails
  NeoBundle 'benmills/vimux'
  NeoBundle 'bps/vim-textobj-python'
  NeoBundle 'christoomey/vim-tmux-navigator'
  NeoBundle 'clones/vim-zsh'
  NeoBundle 'cohama/agit.vim'
  NeoBundle 'deris/vim-visualinc'
  NeoBundle 'deton/jasegment.vim'
  NeoBundle 'elzr/vim-json'
  NeoBundle 'emonkak/vim-operator-sort'
  NeoBundle 'fuenor/im_control.vim'                        " im / ime control plugin for vim
  NeoBundle 'flazz/vim-colorschemes'                       " one colorscheme pack to rule them all!
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'haya14busa/incsearch.vim'
  NeoBundle 'haya14busa/vim-migemo'                        " Vim Plugin for C/Migemo
  NeoBundle 'honza/vim-snippets'
  NeoBundle 'itchyny/calendar.vim'
  NeoBundle 'itchyny/lightline.vim'
  " NeoBundle 'ivanov/vim-ipython'
  NeoBundle 'jpo/vim-railscasts-theme'
  NeoBundle 'kana/vim-operator-replace'
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'kana/vim-smartchr'
  NeoBundle 'kana/vim-textobj-datetime'                    " 日付選択オブジェクト   #ada, add, adt
  NeoBundle 'kana/vim-textobj-entire'                      " 全体選択オブジェクト   #ae, ai
  NeoBundle 'kana/vim-textobj-fold'                        " az, iz
  NeoBundle 'kana/vim-textobj-function'
  NeoBundle 'kana/vim-textobj-user'
  " NeoBundle 'kannokanno/previm'
  NeoBundle 'KazuakiM/vim-qfstatusline'
  NeoBundle 'KazuakiM/vim-regexper'
  NeoBundle 'klen/python-mode'                             " python plugin for vim
  NeoBundle 'davidhalter/jedi-vim'                         " python plugin for vim
  NeoBundle 'koron/codic-vim'
  NeoBundle 'lambdalisue/vim-gista'
  NeoBundle 'lambdalisue/vim-pyenv'                        " Activate the versions and the virtualenvs of pyenv within a live VIM session
  NeoBundle 'lilydjwg/colorizer'                           " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
  NeoBundle 'Lokaltog/vim-easymotion'
  NeoBundle 'majutsushi/tagbar'
  NeoBundle 'matchit.zip'
  NeoBundle 'mattn/benchvimrc-vim'                         " make benchmark result of your vimrc
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'mattn/ginger-vim'
  NeoBundle 'mattn/learn-vimscript'                        " help for vim script
  NeoBundle 'mattn/unite-advent_calendar'
  NeoBundle 'mattn/vim-textobj-url'                        " URLオブジェクト        #au, iu
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'mbbill/undotree'                              " The ultimate undo history visualizer for VIM
  " NeoBundle 'moznion/github-commit-comment.vim'
  NeoBundle 'mrkn/mrkn256.vim'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'NLKNguyen/papercolor-theme'                   " colorscheme paperolor
  NeoBundle 'osyo-manga/shabadou.vim'
  NeoBundle 'osyo-manga/unite-fold'
  NeoBundle 'osyo-manga/vim-precious'                      " Vim constext filetype
  NeoBundle 'osyo-manga/vim-watchdogs'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'rbonvall/vim-textobj-latex'                   " LaTeXオブジェクト      #\, $ q, Q, e
  " NeoBundle 'rcmdnk/vim-markdown'                          " Markdown Vim Mode
  NeoBundle 'rhysd/vim-grammarous'
  NeoBundle 'sgur/vim-textobj-parameter'                   " 引数オブジェクト #a, i,
  NeoBundle 'suan/vim-instant-markdown'                    " Instant Markdown previews from VIm!
  NeoBundle 'Shougo/neobundle-vim-recipes'                 " Use neobundle standard rescipes
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/deoplete.nvim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neossh.vim'
  NeoBundle 'Shougo/unite-outline'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimfiler.vim'
  NeoBundle 'Shougo/vimproc.vim'                           " Enable asynchronous processing in vim
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'sjl/badwolf'
  NeoBundle 'syngan/vim-vimlint'                           " lint for vim script
  NeoBundle 'tacroe/unite-mark'
  NeoBundle 'tejr/vim-tmux'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'thinca/vim-ref'                               " referecen viwer for vim
  NeoBundle 'thinca/vim-singleton'                         " Uses Vim with singleton.
  NeoBundle 'thinca/vim-template'
  NeoBundle 'thinca/vim-textobj-comment'                   " コメントオブジェクト   #ac, ic
  NeoBundle 'thisivan/vim-ruby-matchit'                    " Map '%' to jump from one keyword to its corresponding 'end' in Ruby files. Inspired by 'matchit.vim' that comes with Vim.
  NeoBundle 'TKNGUE/atcoder_helper'
  NeoBundle 'TKNGUE/hateblo.vim'
  NeoBundle 'TKNGUE/sum-it.vim'
  " NeoBundle 'vim-latex/vim-latex'
  NeoBundle 'lervag/vimtex'
  "NeoBundle 'TKNGUE/vim-reveal'
  NeoBundle 'tmhedberg/SimpylFold'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'tpope/vim-commentary'                         " コメント切り替えオペレータ
  NeoBundle 'tpope/vim-endwise'                            " endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'tpope/vim-rails'                              " rails.vim: Ruby on Rails power tools
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-surround'                           " surround記号編集オペレータ
  NeoBundle 'tpope/vim-unimpaired'                         " バッファ移動用等
  NeoBundle 'tsukkee/lingr-vim'
  NeoBundle 'tsukkee/unite-help'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'tyru/open-browser.vim'                        " Open URI with your favorite browser from your most favorite editor
  NeoBundle 'uguu-org/vim-matrix-screensaver'
  NeoBundle 'ujihisa/neco-look'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'vim-jp/vimdoc-ja'                             " Add Help in Japanese
  NeoBundle 'vim-jp/vital.vim'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'vim-scripts/Align'
  NeoBundle 'vim-scripts/CSS-one-line--multi-line-folding'
  " NeoBundle 'vim-scripts/css_color.vim'
  " NeoBundle 'xolox/vim-session'
  NeoBundle 'ingydotnet/yaml-vim'                          " YAML Highlight script for VIM editor
  NeoBundle 'Shougo/context_filetype.vim'                  " Context filetype library for Vim script
  NeoBundle 'stephpy/vim-yaml'                             " Override vim syntax for yaml files
  NeoBundle 'hsanson/vim-android'                          " Android development plugin for vim
  " NeoBundle 'rhysd/github-complete.vim'                    " Vim input completion for GitHub
  " NeoBundle 'thinca/vim-github'                            " An interface for Github.
  NeoBundle 'beloglazov/vim-online-thesaurus'              " A Vim plugin for looking up words in an online thesaurus
  NeoBundle 'kana/vim-submode'                             " Vim plugin: Create your own submodes
  " NeoBundle 'Shougo/junkfile.vim'                          " Create temporary file for memo, testing, ...
  " NeoBundle 'jaxbot/github-issues.vim'                   " Github issue lookup in Vim
  " NeoBundle 'osyo-manga/vim-over'
  " NeoBundle 'welle/targets.vim'
  NeoBundle 'vimperator/vimperator-labs', {
        \   'name': 'vimperator-syntax',
        \   'rtp':  'vimperator/contrib/vim/'
        \ }
  NeoBundle 'Rykka/InstantRst'
  NeoBundle 'Rykka/riv.vim'
  "BUNDLE_ENDPOINT

endfunction "}}}

if !g:noplugin && neobundle#load_cache()
  call s:loads_bundles()
  NeoBundleSaveCache                           "Cacheによるvimの起動の高速化
endif
call neobundle#end()

NeoBundleCheck
" END NeoBundle}}}

" ====================== }}}

" Vim Setup ===================== {{{
" Basic Settings: {{{

" Encodings: {{{
" set encoding=utf8
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
set list lcs=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:⏎
  
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
set updatetime=1000         " Automatically reload change files on disk

set ttimeout
set ttimeoutlen=1000

if has('unnamedplus')
  set clipboard=unnamedplus,autoselect
else
  set clipboard=unnamed,exclude:cons\|linux
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
" nnoremap c  "_c
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

nnoremap z& :<C-u>spellr<CR>

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

function! OpenFolderOfCurrentFile() abort
  let l:path = shellescape(expand('%:p:h'))
  if has('unix') && s:executable('xdg-open')
    call system( 'xdg-open '. path)
  elseif has('mac') && s:executable('open')
    call system('open '. path)
  endif
endfunction

nnoremap <Space>o :call OpenFolderOfCurrentFile()<CR>


" nnoremap <silent><C-F> :<C-U>setl lazyredraw<CR><C-D><C-D>:setl nolazyredraw<CR>
" nnoremap <silent><C-B> :<C-U>setl lazyredraw<CR><C-U><C-U>:setl nolazyredraw<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

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
      let l:mapping = [[[0,1],[1,0]],[[1,1],[0,0]]]
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
" inoremap {} {}<left>
" inoremap () ()<left>
" inoremap [] []<left>
" inoremap <> <><left>
" inoremap '' ''<left>
" inoremap `` ``<left>
" inoremap "" ""<left>

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
  " ファイルタイププラグインおよびインデントを有効化
  " これはNeoBundleによる処理が終了したあとに呼ばなければならない
endif
"}}}

" Misc: {{{
" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

augroup my_diff_autocmd
  autocmd!
  autocmd  InsertLeave *
        \ if &diff | diffupdate | echo 'diffupdated' | endif
augroup END

" 一時ファイルコマンド

" Open junk file:{{{
command! -nargs=? -complete=filetype Memo call s:open_junk_file('<args>')
" command! Memo call s:Memo() " Memoコマンド
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
    " execute 'put a'
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

  " todoリストを簡単に入力する

endfunction "}}}

command! -bang -nargs=* PluginTest call PluginTest(<bang>0, <q-args>)
function! PluginTest(is_gui, extraCommand)
  let cmd = a:is_gui ? 'gvim' : 'vim'
  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * ' . a:extraCommand . '"'
  if !exists('b:git_dir')
    let l:additional_path = fnamemodify(b:git_dir, ':p:h:h')
  else
    let l:additional_path = getcwd()
  endif
  execute '!' . cmd . ' -u ~/.min.vimrc -i NONE -N --cmd "set rtp+=' . additional_path . '"' . extraCommand
endfunction
"
augroup edit_memo
  autocmd! BufNewFile,BufRead *.todo
        \ set nonumber norelativenumber filetype=markdown
  autocmd BufNewFile,BufRead *.memo
        \ set nonumber norelativenumber filetype=markdown
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
    execute 'lcd ' . shellescape(expand('%:p:h'))
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

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
"
augroup MyAutoCmd " {{{
  autocmd!
  "autocmd VimEnter * call s:ChangeCurrentDir('', '')
  autocmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
  " make, grep などのコマンド後に自動的にQuickFixを開く
  autocmd QuickfixCmdPost make,diff,grep,grepadd,vimgrep,vimdiff copen
  " QuickFixおよびHelpでは q でバッファを閉じる
  autocmd FileType help,qf nnoremap <buffer> q <C-w>c
  autocmd CmdwinEnter * nnoremap <buffer>q  <C-w>c
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  autocmd WinLeave * set nocursorline norelativenumber
  autocmd WinEnter * if &number | set cursorline relativenumber | endif
  autocmd BufRead .vimrc setlocal path+=$HOME/.vim/bundle
  " autocmd BufReadPost * call s:SwitchToActualFile()
  autocmd FileType sh,zsh,csh,tcsh let &l:path = substitute($PATH, ':', ',', 'g')
augroup END " }}}

augroup office_format "{{{
  autocmd!
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}  set modifiable
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}  silent %d
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}  silent %read !tika --text %:p
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}  set readonly
  autocmd BufRead *.{docx,xlsx,pptx,ppt,doc,xls,pdf}  normal gg
augroup END "}}}


function! s:SwitchToActualFile() "{{{
  let l:fname = resolve(expand('%:p'))
  let l:pos = getpos('.')
  let l:bufname = bufname('%')
  enew
  exec 'bw '. l:bufname
  exec "e" . fname
  call setpos('.', pos)
endfunction "}}}

command! FollowSymlink  call s:SwitchToActualFile() 

function! s:RestoreCursorPostion() "{{{
  let ignore_filetypes = ['gitcommit']
  if index(ignore_filetypes, &l:filetype) >= 0
    return
  endif

  if line("'\"") > 1 && line("'\"") <= line("$")
    execute 'normal! g`"'
  endif
  try
    normal! zMzv
  catch /E490/
  endtry
endfunction "}}}

augroup vimrc_restore_cursor_position "{{{
  autocmd!
  " Jump to the previous position when file opend
  autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END "}}}

augroup vimrc_change_cursorline_color "{{{
  autocmd!
  " インサートモードに入った時にカーソル行の色をブルーグリーンにする
  " autocmd InsertEnter * highlight CursorLine ctermbg=23 guibg=yellow
  " autocmd InsertEnter * highlight CursorColumn ctermbg=24 guibg=#005f87
  " インサートモードを抜けた時にカーソル行の色を黒に近いダークグレーにする
  " autocmd InsertLeave * highlight CursorLine ctermbg=236 guibg=#303030
  " autocmd InsertLeave * highlight CursorColumn ctermbg=236 guibg=#303030
augroup END "}}}

augroup edit_vimrc "{{{
  autocmd!
  autocmd BufReadPost .vimrc setlocal path+=$HOME/.vim
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END "}}}

" Cached executable "{{{
let s:_executable = {}
function! s:executable(expr) "{{{
  let s:_executable[a:expr] = has_key(s:_executable, a:expr) ?
        \ s:_executable[a:expr] : executable(a:expr)  
  return s:_executable[a:expr]
endfunction "}}}

augroup help_setting
  autocmd!
  autocmd FileType help nnoremap <buffer> <CR>  <C-]>
  autocmd FileType help nnoremap <buffer> <BS>  <C-o>
augroup END
"}}}

"}}}
"}}}

" Plugin Settings ============== {{{

" Bundles Settings:{{{
" Shougo/neobundle-vim-recipes'      {{{
if neobundle#tap('neobundle-vim-recipes')
  " Config {{{
  call neobundle#config({}) 
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}

" Shougo/vimproc.vim {{{
if neobundle#tap('vimproc.vim')
  " Config {{{
  call neobundle#config( {
        \ "build": {
        \   "windows"   : "make -f make_mingw64.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }})
  "}}}

  call neobundle#untap()
endif
" }}}
" }}}

" Design Setting: {{{
" nathanaelkane/vim-indent-guides {{{
if neobundle#tap('vim-indent-guides')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    hi IndentGuidesOdd  ctermbg=237  
    hi IndentGuidesEven ctermbg=None 
  endfunction "}}}

  " Setting {{{
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1 
  let g:indent_guides_default_mapping = 1
  "}}}

  call neobundle#untap()
endif
" }}} "

" itchyny/lightline.vim {{{
if neobundle#tap('lightline.vim')

  " Config {{{
  call neobundle#config({
        \ 'depends': ['tpope/fugitive', 'KazuakiM/vim-qfstatusline']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    augroup LightLineColorscheme
      autocmd!
      autocmd ColorScheme * call s:lightline_update()
    augroup END
  endfunction "}}}

  function! s:lightline_update() "{{{
    if !exists('g:loaded_lightline')
      return
    endif
    try
      if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow\|PaperColor'
        let g:lightline.colorscheme =
              \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
              \ (g:colors_name ==# 'solarized\|PaperColor' ? '_' . &background : '')
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
      endif
    catch
    endtry
  endfunction"}}}

  " Setting {{{

  " Functions {{{
  function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' || &bt == 'nofile' || &previewwindow ?
          \ '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction 

  function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ?  '⭤' : ''
  endfunction

  function! MyFilename() "{{{
    let fname = expand('%:t')
    if fname =~ '^lingr-'
      let fname = '['. fname . ']'
    elseif fname == ''
      let fname = '[No Name]'
    endif
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite'    ? unite#get_status_string()    :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \  &previewwindow    ? '[Preview]':
          \  &bt == 'uuickfix' ? '[Quick Fix]'                :
          \  &bt == 'help'     ? '[Help]'                     :
          \  fname =~ '^['     ?  fname                       :
          \  &bt == 'nofile' && &bh =='hide'  ? '[Scratch]'   :
          \  fname) .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction "}}}


  let s:_lightline = {}
  let s:_lightline_counter = 0
  let g:lightline_update = 20
  function! s:lightline_cache(name, key, val) abort "{{{
    if !has_key(s:_lightline, a:name)
      let s:_lightline[a:name] = {a:key : a:val}
    else
      if !has_key(s:_lightline[a:name], a:key)
        let s:_lightline[a:name][a:key] = a:val
      endif
    endif
  endfunction"}}}
  function! s:lightline_hit(name, key) abort "{{{
    if !has_key(s:_lightline, a:name)
      let s:_lightline[a:name] = {}
      return ''
    else
      if !has_key(s:_lightline[a:name], a:key)
        return ''
      else
        return s:_lightline[a:name][a:key]
      endif
    endif
  endfunction "}}}

  function! MyPyenv() "{{{
    if &ft =~ 'python'
      let key = exists('b:git_dir') ? b:git_dir : expand('%:p')
      let val = s:lightline_hit('pyenv', key)
      if val == ''
        let val = pyenv#info#format('%av')
        call s:lightline_cache('pyenv', key, val)
      endif
      return val
    else
      return ''
    endif
  endfunction "}}}
  function! MyFugitive() "{{{
    let statusline = ''
    " return statusline != '' ? '⭠ '. statusline : ''
    if &ft !~? 'help\|vimfiler\|gundo' && exists('b:git_dir')
      let fname = expand('%')
      if fname == ''
          return ''
      endif
      let statusline = s:lightline_hit('fugitive', fname)
      if statusline == ''
        let statusline = fugitive#head()
        call s:lightline_cache('fugitive', fname, statusline)
      endif  
    endif 
    return statusline != '' ? '⭠ '. statusline : ''
  endfunction "}}}

  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction
  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction
  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction
  function! MyCount()
    if mode() =~ '[vV]\|CTRL-V\|'
      return sumit#count_selected_text()
    else  
      return ''
    endif
  endfunction  
  function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() :lightline#mode()[00] 
  endfunction  
  "}}}

  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'COMMAND'},
        \ 'active': {
        \   'left':  [ [ 'mode', 'paste' ], ['fugitive', 'pyenv', 'rubyenv'], ['filename'] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ],
        \              [ 'count'], ],
        \ },
        \ 'component': {
        \   'lineinfo': '%3l:%-2v',
        \ },
        \ 'component_expand': {
        \   'syntaxcheck': 'qfstatusline#Update',
        \ },
        \ 'component_type': {
        \   'syntaxcheck': 'error',
        \ },
        \ 'component_function': {
        \   'syntaxcheck': 'qfstatusline#Update',
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'count': 'MyCount',
        \   'pyenv': 'MyPyenv',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ },
        \ 'component_visible_condition' :{
        \   'modified': '&modified||!&modifiable',
        \   'readonly': '&readonly'
        \ },
        \ 'separator': { 'left': '⮀', 'right': '⮂' },
        \ 'subseparator': { 'left': '⮁', 'right': '⮃' }} 

  " :WatchdogsRun後にlightline.vimを更新
  let g:Qfstatusline#UpdateCmd = function('lightline#update')
  let g:Qfstatusline#Text      = 0
  "}}}

  call neobundle#untap()
endif
" }}} "

" }}}

" Editing Auxiliary Settings:{{{
" rhysd/vim-grammarous {{{
if neobundle#tap('vim-grammarous')
  " Config {{{
  call neobundle#config( {
        \   'autoload' : {
        \     'commands' : [
        \       'GrammarousCheck',
        \     ],
        \     'mappings' : [
        \       '<Plug>',
        \     ],
        \   }
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" ujihisa/neco-look {{{
if neobundle#tap('neco-look')
  " Config {{{
  call neobundle#config({
        \ 'depends' : ['neocomplete.vim']
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" koron/codic-vim {{{
if neobundle#tap('codic-vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" deris/vim-visualinc {{{
if neobundle#tap('vim-visualinc')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" mattn/ginger-vim {{{
if neobundle#tap('ginger-vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} " 

" Shougo/neocomplete.vim {{{
if neobundle#tap('neocomplete.vim')
  " Config {{{
  call neobundle#config({
        \ 'lazy' : 1,
        \ 'disabled' : !has('lua'),
        \ 'vim_version' : '7.3.885',
        \ 'autoload' : { 'insert' : 1},
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    function! s:my_cr_function()
      " return neocomplete#close_popup() . "\<CR>"
      "For no inserting <CR> key.
      return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    " For smart TAB completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ neocomplete#start_manual_complete()

    function! s:check_back_space() "{{{
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction "}}}   

    " <C-h>, <BS>: close popup and delete backword char.
    if neobundle#is_installed('neosnippet.vim') "{{{
      inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
      " For cursor moving in insert mode(Not recommended)
      inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
      inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
      inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
      inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
      " make neocomplcache use jedi#completions omini function for python scripts

      augroup tex_complete
        autocmd!
        autocmd FileType *.tex inoremap <expr>$$ $$<left>
      augroup END

      " Plugin key-mappings.
      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
      xmap <C-k>     <Plug>(neosnippet_expand_target)
      xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

      " SuperTab like snippets behavior.
      imap <expr><CR>  neosnippet#expandable() ? 
            \ "\<Plug>(neosnippet_expand)" : 
            \ pumvisible() ?  "\<C-Y>".neocomplete#close_popup(): "\<CR>"

      " <TAB>: completion.
      " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      " inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

      " Plugin key-mappings.
      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
      smap <C-k>     <Plug>(neosnippet_expand_or_jump)

      " SuperTab like snippets behavior.
      imap <expr><TAB> neosnippet#jumpable() ? 
            \ pumvisible() ? "\<C-n>" : "\<Plug>(neosnippet_jump_or_expand)" :
            \ pumvisible() ? "\<C-n>" : "\<TAB>"
      smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
    endif
    "}}}
  endfunction "}}}

  " Setting {{{
  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#text_mode_filetypes= {
        \ 'tex' : 1,
        \ 'plaintex' : 1,
        \ 'gitcommit' : 1
        \}
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#max_keyword_width = 50
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#enable_auto_delimiter = 0
  let g:neocomplete#enable_auto_close_preview = 0
  let g:neocomplete#auto_completion_start_length  = 3
  let g:neocomplete#skip_auto_completion_time  = "0.2"
  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }


  let g:neocomplete#enable_multibyte_completion = 1

  " make Vim call omni function when below patterns matchs
  let g:neocomplete#sources#omni#functions = {}

  let g:neocomplete#force_omni_input_patterns = {}
  let g:neocomplete#force_omni_input_patterns.python = 
        \ '\%([^. \t]\{1,}\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

  " let g:neocomplete#sources#omni#input_patterns = {}
  " let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  " let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  " let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " if !exists('g:neocomplete#keyword_patterns')
  "   let g:neocomplete#keyword_patterns = {}
  " endif
  "}}}

  call neobundle#untap()
endif
" }}} "

" Shougo/neosnippet.vim {{{
if neobundle#tap('neosnippet.vim')
  " Config {{{
  call neobundle#config({
        \   'lazy'  : 1 , 
        \   'autoload' : {
        \     'insert' : 1,
        \     'unite_sources' : [
        \       'snippet', 'neosnippet/user', 'neosnippet/runtime'
        \       ],
        \   }
        \ }) "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{

    augroup neosnippet_setting
      autocmd!
      autocmd InsertLeave * NeoSnippetClearMarkers
    augroup END

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=0 concealcursor=nivc
    endif
  endfunction "}}}

  " Setting {{{

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#snippets_directory = ['~/.vim/bundle/vim-snippets/snippets','~/.vim/snippets']
  let g:neosnippet#enable_preview = 0	 

  " inoremap <expr>{} "{}\<\`0\`><C-O>F}"
  " inoremap <expr>() "()\<\`0\`><C-O>F)"
  " inoremap <expr>[] "[]\<\`0\`><C-O>F]"
  " inoremap <expr><> "<>\<\`0\`><C-O>F>"
  " inoremap <expr>'' "''\<\`0\`><C-O>F'"
  " inoremap <expr>`` "``\<\`0\`><C-O>3F`"
  " inoremap <expr>"" "\"\"\<\`0\`><C-O>F\""

  " }}}
  call neobundle#untap()
endif "}}}


" Shougo/neosnippet-snippets {{{
if neobundle#tap('neosnippet-snippets')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'insert' : 1,
        \     'filetypes' : 'neosnippet',
        \     'unite_sources' : [
        \           'snippet', 
        \           'neosnippet/user',
        \           'neosnippet/runtime'
        \       ],
        \   }
        \ })
  "}}}

  call neobundle#untap()
endif
" }}} "

" honza/vim-snippets {{{
if neobundle#tap('vim-snippets')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" haya14busa/vim-migemo {{{
if neobundle#tap('vim-migemo')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \})
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}
" }}}

" Vim Operator Settings: {{{

" kana/vim-operator-user {{{
if neobundle#tap('vim-operator-user')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" kana/vim-operator-replace {{{
if neobundle#tap('vim-operator-replace')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    map _ <Plug>(operator-replace)
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" tpope/vim-commentary'                         {{{
if neobundle#tap('vim-commentary')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "コメント切り替えオペレータ

" tpope/vim-repeat {{{
if neobundle#tap('vim-repeat')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" tpope/vim-unimpaired'                         {{{
if neobundle#tap('vim-unimpaired')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "バッファ移動用等

" emonkak/vim-operator-sort {{{
if neobundle#tap('vim-operator-sort')
  " Config {{{
  call neobundle#config( {
        \ 'depends' : ['tpope/vim-operator-user']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" pekepeke/vim-operator-tabular {{{
if neobundle#tap('vim-operator-tabular')
  " Config {{{
  call neobundle#config( {
        \ 'depends' : ['pekepeke/vim-csvutil']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" wellle/targets.vim {{{
if neobundle#tap('targets.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" AndrewRadev/switch.vim                            {{{
if neobundle#tap('switch.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    augroup switch_autocmd
      autocmd FileType gitrebase let b:switch_custom_definitions = [
            \ ['pick' , 'reword', 'edit'  , 'squash' , 'fixup' , 'exec'],
            \]
      autocmd FileType python let g:switch_custom_definitions =
            \[
            \   ['and', 'or'],
            \   {
            \     '\(.\+\) if \(.\+\) else \(.\+\)' : { 
            \        '\(\s*\)\(.\+\) = \(.\+\) if \(.\+\) else \(.\+\)' : 
            \             '\1if \4:\1    \2 = \3\1else:\1    \2 = \5'
            \      }
            \   },
            \]
    augroup END

    let g:switch_custom_definitions = [
          \   ['TRUE', 'FALSE'], ['True', 'False'], ['true', 'false'],
          \   ['ENABLE', 'DISABLE'], ['Enable', 'Disable'], ['enable', 'disable'],
          \   ['!=', '=='],
          \   {
          \     '>\(=\)\@!'  : '>=',
          \     '>='  : '<',
          \     '<\(=\)\@!'  : '<=',
          \     '<='  : '>',
          \   },
          \   {
          \     '\<[a-z0-9]\+_\k\+\>': { 
          \       '_\(.\)': '\U\1',
          \       '\<\(.\)': '\U\1'
          \     },
          \     '\<[A-Za-z][a-z0-9]\+[A-Z]\k\+\>': {
          \       '\(\u\)': '_\l\1',
          \       '\<_': ''
          \     },
          \   }
          \ ]
    let g:switch_increment_definitions = []
    let g:switch_decrement_definitions = []
  endfunction "}}}

  let g:switch_mapping = "-"
  "}}}

  call neobundle#untap()
endif
" }}} "true ⇔ falseなどの切り替え

" Text Object Settings: {{{
" kana/vim-operator-fold {{{
if neobundle#tap('vim-textobj-fold')
  " Config {{{
  call neobundle#config({})
  "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
"}}}
" kana/vim-textobj-user {{{
if neobundle#tap('vim-textobj-user')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" sgur/vim-textobj-parameter'                   {{{
if neobundle#tap('vim-textobj-parameter')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "引数オブジェクト #a, i,

" kana/vim-textobj-entire"                      {{{
if neobundle#tap('vim-textobj-entire')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "全体選択オブジェクト   #ae, ai

" kana/vim-textobj-datetime"                    {{{
if neobundle#tap('vim-textobj-datetime')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "日付選択オブジェクト   #ada, add, adt

" thinca/vim-textobj-comment"                   {{{
if neobundle#tap('vim-textobj-comment')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "コメントオブジェクト   #ac, ic×

" mattn/vim-textobj-url"                        {{{
if neobundle#tap('vim-textobj-url')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "URLオブジェクト        #au, iu

" rbonvall/vim-textobj-latex                   {{{
if neobundle#tap('vim-textobj-latex')
  " Config {{{
  call neobundle#config({
        \ 'lazy' : 1,
        \ 'autoload' : {'filetypes' : ['tex']},
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "LaTeXオブジェクト      #\, $ q, Q, e

" kana/vim-textobj-function {{{
if neobundle#tap('vim-textobj-function')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ 'script_ytype' : 'ftplugin',
        \ 'autoload' : {
        \   'filetypes' : ['cpp', 'java', 'vim']
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" bps/vim-textobj-python {{{
if neobundle#tap('vim-textobj-python')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ 'script_ytype' : 'ftplugin',
        \ 'autoload' : {
        \   'filetypes' : ['python', 'pytest']
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" michaeljsmith/vim-indent-object'              {{{
if neobundle#tap('vim-indent-object')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "同Indentオブジェクト   #ai. ii, aI, iI
" }}}

" Programming Tools Settings: {{{

" Programming Utilities: {{{
"
" thinca/vim-quickrun {{{
if neobundle#tap('vim-quickrun')
  " Config {{{
  call neobundle#config({
        \'autoload' : {
        \     'commands' : [
        \       'QuickRun',
        \     ],
        \},
        \'depends' : ['Shougo/vimproc.vim', 'shabadou.vim']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    nnoremap <silent> <Leader>r :QuickRun<CR>
    nnoremap <silent><expr> <Leader>d eval('":QuickRun <". b:input_file . "<CR>"')
    nnoremap <silent> <Leader>se :QuickRun sql<CR>
  endfunction "}}}

  " Setting {{{
  let g:quickrun_config = {
        \ "_": {
        \   "hook/my_anime/enable" : 1,
        \   "hook/my_anime/wait" : 2,
        \   "hook/qfsigns_update/enable_exit":   1,
        \   "hook/qfsigns_update/priority_exit": 3,
        \   "hook/qfstatusline_update/enable_exit" : 1,
        \   "hook/qfstatusline_update/priority_exit" : 4,
        \   "runner"                   : 'vimproc',
        \   "runner/vimproc/read_timeout" : 100,
        \   "runner/vimproc/sleep"      : 100,
        \   "runner/vimproc/updatetime" : 100,
        \   "outputter/buffer/split"    : 'bot %{winwidth(0) * 2 > winheight(0) * 5 ? "vertical" : ""}',
        \},
        \   "watchdogs_checker/_" : {
        \      "hook/close_quickfix/enable_exit" : 1,
        \      "runner/vimproc/updatetime" : 1000,
        \}}
  let g:quickrun_config.sql ={
        \ 'command' : 'mysql',
        \ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
        \ 'exec'    : ['%c %o < %s' ] ,
        \}
  let g:quickrun_config['php.unit'] = {
        \ 'command': 'testrunner',
        \ 'cmdopt': 'phpunit'
        \} 
  let g:quickrun_config['python'] = {
        \ 'command': 'python',
        \}
  let g:quickrun_config['python/watchdogs_checker'] = {
        \  "type" : "watchdogs_checker/flake8",
        \}
  let g:quickrun_config['python.pytest'] = {
        \ 'command': 'py.test',
        \ 'cmdopt': '-v'
        \}
  let g:quickrun_config.markdown  = {
        \ 'type' : 'markdown/pandoc',
        \ 'cmdopt': '-v -s -mathjax -f markdown -t html',
        \ 'outputter' : 'browser'
        \ }
  let g:quickrun_config.html  = {
        \ 'command' : 'cygstart',
        \ 'cmdopt'  : '%c %o' ,
        \ 'outputter' : 'browser'
        \ }
  let g:quickrun_config['ruby.rspec']  = {
        \ 'command': 'rspec'
        \ , 'cmdopt': '-f d'
        \ }


  function! MakeMySQLCommandOptions()
    if !exists("g:mysql_config_usr")
      let g:mysql_config_user = input("user> ")
    endif
    if !exists("g:mysql_config_host") 
      let g:mysql_config_host = input("host> ")
    endif
    if !exists("g:mysql_config_port")
      let g:mysql_config_port = input("port> ")
    endif
    if !exists("g:mysql_config_pass")
      let g:mysql_config_pass = inputsecret("password> ")
    endif
    if !exists("g:mysql_config_db") 
      let g:mysql_config_db = input("database> ")
    endif

    let optlist = []
    if g:mysql_config_user != ''
      call add(optlist, '-u ' . g:mysql_config_user)
    endif
    if g:mysql_config_host != ''
      call add(optlist, '-h ' . g:mysql_config_host)
    endif
    if g:mysql_config_db != ''
      call add(optlist, '-D ' . g:mysql_config_db)
    endif
    if g:mysql_config_pass != ''
      call add(optlist, '-p' . g:mysql_config_pass)
    endif
    if g:mysql_config_port != ''
      call add(optlist, '-P ' . g:mysql_config_port)
    endif
    if exists("g:mysql_config_otheropts")
      call add(optlist, g:mysql_config_otheropts)
    endif
    return join(optlist, ' ')
  endfunction 

  augroup QuickRunUnitTest
    autocmd!
    autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
    "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
    autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
    autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
    autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
  augroup END

  "}}}

  call neobundle#untap()
endif
" }}}

" osyo-manga/vim-watchdogs {{{
if neobundle#tap('vim-watchdogs')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \     'commands' : [
        \       {
        \         'name' : 'WatchdogsRun',
        \         'complete' : 'customlist,quickrun#complete'
        \       },
        \     ],
        \   },
        \   'depends' : ['thinca/vim-quickrun', 'Shougo/vimproc.vim', 'osyo-manga/shabadou.vim',
        \       'jceb/vim-hier', 'dannyob/quickfixstatus', 'KazuakiM/vim-qfsigns',
        \    ]
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:watchdogs_check_BufWritePost_enables = {
        \   "cpp"     : 1,
        \   "python"  : 0,
        \   "ruby"    : 1,
        \   "haskell" : 1,
        \}

  let g:watchdogs_check_CursorHold_enables = {
        \   "cpp"     : 1,
        \   "python"  : 0,
        \   "ruby"    : 1,
        \   "haskell" : 1,
        \}
  let g:watchdogs_check_BufWritePost_enable_on_wq = 0
  "}}}
  call neobundle#untap()
endif
" }}}

"}}}

" Ruby: {{{
" tpope/vim-rails {{{  
if neobundle#tap('vim-rails')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}

" thisivan/vim-ruby-matchit {{{
if neobundle#tap('vim-ruby-matchit')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}

" vim-ruby/vim-ruby {{{
if neobundle#tap('vim-ruby')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ["ruby"],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "
"}}}

" Python: {{{
" alfredodeza/pytest.vim {{{
if neobundle#tap('pytest.vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ 'external-commands' : ['pytest'],
        \ 'autoload'    : {
        \   'filetypes' : ['python', 'python3', 'pytest'],
        \ },
        \ 'build'       : {
        \   "cygwin"    : "pip install --user pytest",
        \   "mac"       : "pip install --user pytest",
        \   "unix"      : "pip install --user pytest"
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    nnoremap  <silent><F5>      <Esc>:Pytest file verbose<CR>
    nnoremap  <silent><C-F5>    <Esc>:Pytest class verbose<CR>
    nnoremap  <silent><S-F5>    <Esc>:Pytest project verbose<CR>
    nnoremap  <silent><F6>      <Esc>:Pytest session<CR>
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "
"
" voithos/vim-python-matchit {{{
if neobundle#tap('vim-python-matchit')
  " Config {{{
  call neobundle#config( {
        \ "lazy"    : 1,
        \ "autoload"    : {
        \   "filetypes" : ["python", "python3", "djangohtml"]
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" klen/python-mode {{{
if neobundle#tap('python-mode')
  " Config {{{
  call neobundle#config( {
        \ 'lazy' : 1,
        \ 'external_commands' : ['pyflakes', 'pylint'],
        \ "disable"    : !has('python'),
        \ "autoload"    : {
        \   "filetypes" : ["python", "python3", "djangohtml"],
        \ },
        \ "build"       : {
        \   "cygwin"    : "pip install --user pylint rope pyflake pep8",
        \   "mac"       : "pip install --user pylint rope pyflake pep8",
        \   "unix"      : "pip install --user pylint rope pyflake pep8"
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    nnoremap <silent><F8> :<C-u>PymodeLintAuto<CR>
    nnoremap <silent><expr><leader>R  ":<C-u>VimShellInteractive --split='bot split \| resize 20' python ". expand('%').'<CR>'

    augroup pymode_myautocmd
      autocmd!
      autocmd BufEnter __doc__ nnoremap <buffer>q  <C-w>c
      autocmd BufEnter __doc____rope__ nnoremap <buffer>q  <C-w>c
    augroup END
  endfunction "}}}

  " Setting {{{
  let g:pymode = 1
  let g:pymode_warnings = 1
  " let g:pymode_paths = ['shutil', 'datetime', 'time',
  "       \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
  let g:pymode_trim_whitespaces = 1
  let g:pymode_options = 1
  let g:pymode_options_colorcolumn = 1
  let g:pymode_quickfix_minheight = 3
  let g:pymode_quickfix_maxheight = 6
  let g:pymode_python = 'python'
  " let g:pymode_indent = []
  let g:pymode_folding = 1
  let g:pymode_motion = 1

  let g:pymode_doc = 1
  let g:pymode_doc_bind = 'K'

  let g:pymode_virtualenv = 0
  let g:pymode_virtualenv_path = $PYENV_ROOT. "/versions"

  let g:pymode_run = 0            "QuickRunの方が優秀
  " let g:pymode_run_bind = '<leader>R'

  let g:pymode_breakpoint = 1
  let g:pymode_breakpoint_bind = '<leader>b'

  let g:pymode_lint = 1
  let g:pymode_lint_on_write = 1

  "Check code on every save (every)
  let g:pymode_lint_unmodified = 0
  let g:pymode_lint_on_fly = 0
  let g:pymode_lint_message = 1
  " let g:pymode_lint_ignore = "E501,W"
  " let g:pymode_lint_select = "E501,W0011,W430"
  let g:pymode_lint_cwindow = 0

  let g:pymode_rope = 0
  let g:pymode_rope_autoimport = 0
  " let g:pymode_rope_autoimport_modules = ['shutil', 'datetime', 'time',
  "             \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
  " let g:pymode_rope_autoimport_import_after_complete = 0
  " let g:pymode_rope_organize_imports_bind = '<F11>'

  " let g:pymode_rope_goto_definition_bind = 'gf'
  " " let g:pymode_rope_goto_definition_cmd = 'botrightn new'

  " let g:pymode_rope_rename_bind = 'R'
  " " let g:pymode_rope_rename_module_bind = '<C-S-R>'

  " let g:pymode_rope_extract_method_bind = '<C-c>rm'
  " let g:pymode_rope_extract_variable_bind = '<C-c>rl'
  " let g:pymode_rope_use_function_bind = '<C-c>ru'

  " "よくわからない機能たち
  " " let g:pymode_rope_move_bind = '<C-c>rv'
  " " let g:pymode_rope_change_signature_bind = '<C-c>rs'
  " let g:pymode_lint_sort = ['E', 'C', 'I']  

  let g:pymode_syntax_slow_sync = 0
  let g:pymode_syntax_all = 1
  let g:pymode_syntax_print_as_function = 0
  let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
  let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
  " Highlight 'self' keyword
  let g:pymode_syntax_highlight_self           = g:pymode_syntax_all
  " Highlight indent's errors
  let g:pymode_syntax_indent_errors            = g:pymode_syntax_all
  " Highlight space's errors
  let g:pymode_syntax_space_errors             = g:pymode_syntax_all
  " Highlight string formatting
  let g:pymode_syntax_string_formatting        = g:pymode_syntax_all
  let g:pymode_syntax_string_format            = g:pymode_syntax_all
  let g:pymode_syntax_string_templates         = g:pymode_syntax_all
  let g:pymode_syntax_doctests                 = g:pymode_syntax_all
  " Highlight builtin objects (True, False, ...)
  let g:pymode_syntax_builtin_objs             = g:pymode_syntax_all
  " Highlight builtin types (str, list, ...)
  let g:pymode_syntax_builtin_types            = g:pymode_syntax_all
  " Highlight exceptions (TypeError, ValueError, ...)
  let g:pymode_syntax_highlight_exceptions     = g:pymode_syntax_all
  " Highlight docstrings as pythonDocstring (otherwise as pythonString)
  let g:pymode_syntax_docstrings               = g:pymode_syntax_all

  "}}}
  call neobundle#untap()
endif
" }}} "

" davidhalter/jedi-vim {{{
if neobundle#tap('jedi-vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy"    : 1,
        \ "disabled"    : !has('python'),
        \ "autoload"    : {
        \   "on_source" : ['python-mode'],
        \ },
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    " If not setting this, set pythoncomplete to omnifunc, which is uncomfortable
    call jedi#configure_call_signatures()
    augroup myjedivim
      autocmd!
      autocmd FileType python nnoremap <silent> <buffer> R :call jedi#rename()<cr>
      autocmd FileType python nnoremap <silent> <buffer> <LocalLeader>n :call jedi#usages()<cr>
      autocmd FileType python nnoremap <silent> <buffer> gf :call jedi#goto_assignments()<cr>
      autocmd FileType python nnoremap <silent> <buffer> gd :call jedi#goto_definitions()<cr>
      autocmd FileType python nnoremap <silent> <buffer> K :call jedi#show_documentation()<cr>
      autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
  endfunction "}}}

  " Setting {{{
  " let g:jedi#completions_command = "<C-N>"
  " 自動設定機能をoffにし手動で設定を行う
  set noshowmode
  let g:jedi#auto_initialization  = 0
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#auto_close_doc = 0
  let g:jedi#show_call_signatures = 2
  "

  "quickrunと被るため大文字に変更
  " let g:jedi#rename_command = 'R'
  " let g:jedi#goto_assignments_command = 'gf'
  " let g:jedi#goto_definitions_command = 'gd'
  " let g:jedi#use_tabs_not_buffers = 1
  " let g:jedi#completions_enabled = 1
  "
  " Configuration necocomplete, because of conflicts to one {{{
  if !exists('g:neocomplete#sources#omni#functions')
    let g:neocomplete#sources#omni#functions = {}
  endif
  let g:neocomplete#sources#omni#functions.python = 'jedi#completions'

  " if !exists('g:neocomplete#force_omni_input_patterns')
  "   let g:neocomplete#sources#omni#input_patterns.python = ''
  " endif
  " let g:neocomplete#force_omni_input_patterns.python = 
  "       \ '\%([^. \t]\{1,}\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  "}}}

  call neobundle#untap()
endif
" }}} "
"}}}

" lambdalisue/vim-pyenv {{{
if neobundle#tap('vim-pyenv')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'disabled'    : !has('python'),
        \   'external_commands'    : ['pyenv'],
        \   'autoload' : {
        \   "filetypes" : ["python", "python3", "djangohtml"],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:pyenv#auto_create_ctags = 0
  let g:pyenv#auto_assign_ctags  = 1
  "}}}

  call neobundle#untap()
endif
" }}}
"}}}

" Vim: {{{
" syngan/vim-vimlint {{{
if neobundle#tap('vim-vimlint')
  " Config {{{
  call neobundle#config({
        \ 'lazy' : 1,
        \ 'depends' : 'ynkdir/vim-vimlparser',
        \ 'autoload' : {
        \   'filetypes' : 'vim',
        \   'functions' : 'vimlint#vimlint',
        \   'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}

"}}}

" WEB Programming: {{{
" mattn/emmet-vim {{{
if neobundle#tap('emmet-vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['html', 'css'],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    let g:user_emmet_leader_key = '<C-Y>'
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" vim-scripts/css_color.vim {{{
if neobundle#tap('css_color.vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['html','css'],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" hail2u/vim-css3-syntax {{{
if neobundle#tap('vim-css3-syntax')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['css'],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}

" othree/html5.vim {{{
if neobundle#tap('html5.vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['html', 'svg', 'rdf'],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" elzr/vim-json {{{
if neobundle#tap('vim-json')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['json'],
        \ },})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:vim_json_syntax_conceal = 2
  "}}}

  call neobundle#untap()
endif
" }}} 

"}}}

" Java:

" Android: {{{
" hsanson/vim-android {{{
if neobundle#tap('vim-android')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:android_sdk_path = $ANDROID_SDK
  " let g:gradle_path = /path/to/gradle
  "}}}

  call neobundle#untap()
endif
" }}}
"}}}

"Writing: {{{

" vim-latex/vim-latex {{{
if neobundle#tap('vim-latex')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \ "autoload": {
        \   "filetypes": ["tex"],
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    set grepprg=grep\ -nH\ $*
    "キー配置の変更
    ""<Ctrl + J>はパネルの移動と被るので番うのに変える
    imap <C-n> <Plug>IMAP_JumpForward
    nmap <C-n> <Plug>IMAP_JumpForward
    vmap <C-n> <Plug>IMAP_DeleteAndJumpForward 
    " if !has('gui_running')
    "     set <m-i>=i
    "     set <m-b>=b
    "     set <m-l>=l
    "     set <m-c>=c
    " endif
    nnoremap j g<Down>
    nnoremap k g<Up>
    nnoremap gj j
    nnoremap gk k
  endfunction "}}}

  " Setting {{{
  let g:tex_flavor='latex'
  let g:Imap_UsePlaceHolders = 1
  let g:Imap_DeleteEmptyPlaceHolders = 1
  let g:Imap_StickyPlaceHolders = 0
  let g:Tex_DefaultTargetFormat = 'pdf'
  let g:Tex_MultipleCompileFormats='pdf'
  " let g:Tex_FormatDependency_pdf = 'dvi,pdf'
  " let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
  let g:Tex_FormatDependency_ps = 'dvi,ps'
  let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
  "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
  "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
  "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
  "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
  "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
  let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
  let g:Tex_BibtexFlavor = 'upbibtex'
  let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
  let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
  " let g:Tex_UseEditorSettingInDVIViewer = 1
  " let g:Tex_ViewRule_pdf = 'xdg-open'
  " let g:Tex_ViewRule_pdf = 'evince_sync'
  let g:Tex_ViewRule_pdf = 'evince'
  "let g:Tex_ViewRule_pdf = 'okular --unique'
  "let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
  "let g:Tex_ViewRule_pdf = 'qpdfview --unique'
  "let g:Tex_ViewRule_pdf = 'texworks'
  "let g:Tex_ViewRule_pdf = 'mupdf'
  "let g:Tex_ViewRule_pdf = 'firefox -new-window'
  "let g:Tex_ViewRule_pdf = 'chromium --new-window'
  let g:Tex_IgnoreLevel = 9 
  let g:Tex_IgnoredWarnings = 
        \"Underfull\n".
        \"Overfull\n".
        \"specifier changed to\n".
        \"You have requested\n".
        \"Missing number, treated as zero.\n".
        \"There were undefined references\n".
        \"Citation %.%# undefined\n".
        \"LaTeX Font Warning: Font shape `%s' undefined\n".
        \"LaTeX Font Warning: Some font shapes were not available, defaults substituted."
  "}}}

  call neobundle#untap()
endif
" }}} 

" lervag/vimtex {{{
if neobundle#tap('vimtex')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'filetypes': ['tex'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    nnoremap <buffer> <Space>la :call latex#motion#next_section(0,1,0)<CR>v:call latex#motion#next_section(0,0,1)<CR>:call <SID>previewTex()<CR>
    vnoremap <buffer> <Space>la :call <SID>previewTex()<CR>
    nnoremap <buffer> <Space>ls :call <SID>syncTexForward()<CR>
  endfunction "}}}

  " Setting {{{
  " fold
  let g:latex_fold_parts = [
        \ "appendix",
        \ "frontmatter",
        \ "mainmatter",
        \ "backmatter",
        \ ]
  let g:latex_fold_sections = [
        \ "part",
        \ "chapter",
        \ "section",
        \ "subsection",
        \ "subsubsection",
        \ ]
  let g:latex_fold_enabled = 1
  let g:latex_fold_automatic = 1
  let g:latex_fold_envs = 1

  " let g:vimtex_latexmk_options = '--pdfdvi'

  if has('unix') && s:executable('okular')
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
    let g:vimtex_view_general_options_latexmk = '--unique'
  elseif has('mac')
    let g:vimtex_view_general_viewer
          \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '@line @pdf @tex'
  endif


  " 自動コンパイル
  let g:latex_latexmk_continuous = 1
  let g:latex_latexmk_background = 1
  " コンパイル終了後のエラー通知オフ
  let g:latex_latexmk_callback = 0

  let g:latex_toc_split_pos = "topleft"
  let g:latex_toc_width = 10

  " SyncTex
  function! s:syncTexForward() "{{{
    call system('/Applications/Skim.app/Contents/SharedSupport/displayline -g '
          \ . line(".") . " "
          \ . g:latex#data[b:latex.id].out() . " "
          \ . expand('%:p'))
  endfunction"}}}

  " Preview
  function! s:previewTex() range "{{{
    let l:tmp = @@
    silent normal gvy
    let l:selected = split(@@, "\n")
    let @@ = l:tmp

    let l:template1 = ["\\documentclass[a4paper]{jsarticle}",
          \"\\usepackage[dvipdfmx]{graphicx}",
          \"\\usepackage{amsmath,amssymb,bm}",
          \"\\pagestyle{empty}",
          \"\\begin{document}"]
    let l:template2 = ["\\end{document}"]

    let l:output_file = "preview.tex"
    call writefile(extend(extend(l:template1, l:selected), template2), l:output_file)
    silent call system("latexmk -pdfdvi preview &")
  endfunction"}}}

  " for neocomplete
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.tex = '\\ref{\s*[0-9A-Za-z_:]*'
  "\citeも自動補完するなら
  let g:neocomplete#sources#omni#input_patterns.tex = '\\cite{\s*[0-9A-Za-z_:]*\|\\ref{\s*[0-9A-Za-z_:]*'
  "}}}

  call neobundle#untap()
endif
" }}}

" rcmdnk/vim-markdown {{{
if neobundle#tap('vim-markdown')
  " Config {{{
  call neobundle#config( {
        \  'lazy' : 1,
        \  'autoload' : {
        \     'filetypes': ['markdown'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   },
        \  'depends' : ['godlygeek/tabular', 'joker1007/vim-markdown-quote-syntax']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:vim_markdown_math=0
  let g:vim_markdown_frontmatter = 0
  let g:vim_markdown_no_default_key_mappings = 0
  let g:vim_markdown_better_folding=0

  let g:vim_markdown_initial_foldlevel=2
  let g:vim_markdown_folding_disabled=1
  "}}}


  call neobundle#untap()
endif
" }}} "

" TKNGUE/hateblo.vim {{{
if neobundle#tap('hateblo.vim')
  " Config {{{
  call neobundle#config({
        \ 'lazy'  : 1,
        \ 'autoload'  : {
        \   'commands' : ['HatebloCreate', 'HatebloList', 'HatebloCreateDraft'],
        \ },
        \ 'depends'  : ['mattn/webapi-vim', 'Shoug/unite.vim'],
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:hateblo_config_path = '$HOME/.hateblo/.hateblo.vim'
  let g:hateblo_dir = '$HOME/.hateblo/blog'
  "}}}
  call neobundle#untap()
endif
" }}} "

" TKNGUE/vim-reveal {{{
if neobundle#tap('vim-reveal')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['markdown', 'md'],
        \},
        \})
  "}}}
  "

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    command! -buffer -nargs=0 RevealIt   call reveal#Md2Reveal() 
    command! -buffer -nargs=0 RevealOpen call reveal#open(reveal#preview_file_path())
    command! -buffer -nargs=0 RevealEdit execute 'edit '.reveal#preview_file_path()
  endfunction "}}}

  " Setting {{{
  let g:reveal_root_path = '~/.projects/reveal.js'
  let g:revel_default_config = {
        \ 'fname'  : 'reveal',
        \ 'key1'  : 'reveal'
        \ }
  "}}}

  call neobundle#untap()
endif
" }}} "

" suan/vim-instant-markdown {{{
if neobundle#tap('vim-instant-markdown')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'filetypes' : 'markdown',
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   },
        \ "build"       : {
        \   "unix"      : "npm -g install instant-markdown-d",
        \   "mac"       : "npm -g install instant-markdown-d",
        \}})
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{

  " vim-instant-markdown will update the display in realtime
  let g:instant_markdown_slow = 1

  " you want to manually control this behavior
  let g:instant_markdown_autostart = 0
  "}}}

  call neobundle#untap()
endif
" }}}

" kannokanno/previm {{{
if neobundle#tap('previm')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \ "autoload"    : {
        \   "filetypes" : ['markdown'],
        \   "depends" : ['open-browser.vim'],
        \ },
        \ "build"       : {
        \   "cygwin"    : "pip install --user docutils",
        \   "mac"       : "pip install --user docutils",
        \   "unix"      : "pip install --user docutils"
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "
"
" Rykka/InstantRst {{{
if neobundle#tap('InstantRst')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \   "filetypes": ["rst"],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    " let g:instant_rst_browser = 'xdg-open'
    " let g:instant_rst_localhost_only = 0
    " let g:instant_rst_bind_scroll  = 1
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:instant_rst_localhost_only  = 1
  "}}}

  call neobundle#untap()
endif
" }}}
"}}}


" clones/vim-zsh {{{
if neobundle#tap('vim-zsh')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}}
" }}}

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
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    call unite#custom#profile('default', 'context', {
          \   'start_insert': 1,
          \   'prompt': '» ',
          \ })
    nnoremap [unite]    <Nop>
    nmap    <Leader>f  [unite]
    nnoremap  [unite]s  :<C-u>Unite source<CR>
    nnoremap  [unite]f  :<C-u>Unite -buffer-name=files -no-split
          \ bookmark buffer  file file_mru 
          \ file/new directory/new <CR>
    nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files 
          \ buffer bookmark file file_rec/git file
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
    nnoremap <silent> [unite]gj :<C-u>Unite -buffer-name=search-junks grep:$HOME/Dropbox/junks:-iR<CR>
    nnoremap <silent> [unite]gg :<C-u>Unite -buffer-name=search-cd grep:./:-iR<CR>
    nnoremap <silent> [unite]gc :<C-u>Unite -buffer-name=search-current-word grep:$buffers::<C-R><C-W><CR>
    nnoremap <silent> [unite]R  :<C-u>Unite -buffer-name=resume resume<CR>
    nnoremap <silent> [unite]h  :<C-u>Unite -buffer-name=help help<CR>
    nnoremap <silent> [unite]z :<C-u>Unite -silent fold -vertical -winwidth=40 -no-start-insert<CR>
    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord -buffer-name=help help<CR>

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


    setl nofoldenable
  endfunction "}}}

  " mappingが競合するためデフォルトマッピング無効
  " let g:unite_no_default_keymappings = 1
  " nnoremap <silent> <Plug>(unite_exit)

  " unite grep に ag(The Silver Searcher) を使う
  if s:executable('ag')
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
    call vimfiler#custom#profile('default', 'context', {
          \ 'safe' : 0,
          \ })
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
    nmap <buffer> p <Plug>(vimfiler_quick_look)
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
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    autocmd BufEnter *
          \   if empty(&buftype)
    " \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
          \|  endif
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

" Utilities Settings: {{{

" Shougo/vimshell {{{
if neobundle#tap('vimshell')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ 'autoload' : {
        \   'commands' : ['VimShell']
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
    call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

    autocmd FileType int-* call s:interactive_settings()

    autocmd FileType vimshell
          \ call vimshell#altercmd#define('g', 'git')
          \| call vimshell#altercmd#define('i', 'iexe')
          \| call vimshell#altercmd#define('l', 'll')
          \| call vimshell#altercmd#define('ll', 'ls -l')
          \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')
  endfunction "}}}

  " Setting {{{
  nnoremap <silent> <Leader>vs :VimShell<CR>
  nnoremap <silent> <Leader>vsc :VimShellCreate<CR>
  nnoremap <silent> <Leader>vp :VimShellPop<CR>

  let g:vimshell_interactive_update_time = 10

  " vimshell setting
  let g:vimshell_interactive_update_time = 10
  " vimshell map
  "let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_right_prompt = 'fnamemodify(getcwd(), ":p:~")'

  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% ". $HOST
  endif

  " Initialize execute file list.
  let g:vimshell_execute_file_list = {}
  let g:vimshell_execute_file_list['rb'] = 'ruby'
  let g:vimshell_execute_file_list['pl'] = 'perl'
  let g:vimshell_execute_file_list['py'] = 'python'
  function! MyChpwd(args, context)
    call vimshell#execute('ls')
  endfunction
  "}}}

  call neobundle#untap()
endif
" }}} "

" thinca/vim-template {{{
if neobundle#tap('vim-template')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:template_basedir = '~/.vim'
  autocmd User plugin-template-loaded call s:template_keywords()
  autocmd User plugin-template-loaded 
        \    if search('<+CURSOR+>')
        \  |   normal! dae
        \  | endif

  function! s:template_keywords()
    silent! %s/<+FILE NAME+>/\=expand('%:t')/g
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+MONTH+>/\=strftime('%m')/g
    silent! %s/<+PLUGIN_NAME NAME+>/\=input('%:t')/g
    " And more...
  endfunction

  command! -nargs=0 -complete=filetype Temp call s:open_template()
  nmap <Space>/ :<C-u>call <SID>open_template()<CR>
  function! s:open_template()
    let l:template_name = template#search(expand('%:p'))
    if l:template_name == ''
      let l:template_name = g:template_basedir. '/template/template.'. &ft
    endif
    let l:filename = input('Template("template" are replaced with wild card): ', l:template_name)
    if l:filename != ''
      let l:template_dir= fnamemodify(l:filename, ":p:h")
      if !isdirectory(l:template_dir)
        call mkdir(l:template_dir, 'p')
      endif
      execute 'edit ' . l:filename
    endif
  endfunction
  "}}}


  call neobundle#untap()
endif
" }}} "

" vim-scripts/Align {{{
if neobundle#tap('Align')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" osyo-manga/vim-over {{{
if neobundle#tap('vim-over')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:over_enable_cmd_windw = 1
  " over.vimの起動  
  nnoremap <silent> <Leader>m :OverCommandLine<CR> 
  "}}}

  call neobundle#untap()
endif
" }}} "

" deton/jasegment.vim {{{
if neobundle#tap('jasegment.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" kana/vim-smartchr {{{
if neobundle#tap('vim-smartchr')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ "autoload": {
        \   "filetypes": ["tex"],
        \ }})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" xolox/vim-session {{{
if neobundle#tap('vim-session')
  " Config {{{
  call neobundle#config( {
        \ 'depends' : 'xolox/vim-misc',
        \ })
  "}}}


  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
    if isdirectory(s:local_session_directory)
      " session保存ディレクトリをそのディレクトリの設定
      let g:session_directory = s:local_session_directory
      " vimを辞める時に自動保存
      let g:session_autosave = 'yes'
      " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
      let g:session_autoload = 'yes'
      " 1分間に1回自動保存
      let g:session_autosave_periodic = 1
    else
      let g:session_autosave = 'no'
      let g:session_autoload = 'no'
    endif
    unlet s:local_session_directory

  endfunction "}}}

  " Setting {{{
  " 現在のディレクトリ直下の .vimsessions/ を取得 
  command! MkDirSession call s:mk_dirsession()
  function! s:mk_dirsession()    "session用のディレクトリ作成関数
    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
    call mkdir(s:local_session_directory)
    let g:session_directory = s:local_session_directory
    unlet s:local_session_directory
  endfunction
  "}}}

  call neobundle#untap()
endif
" }}} "

" lambdalisue/vim-gista {{{
if neobundle#tap('vim-gista')
  " Config {{{
  call neobundle#config({
        \ "lazy": 1,
        \ 'depends': [
        \	'Shougo/unite.vim',
        \	'tyru/open-browser.vim',
        \],
        \ 'autoload': {
        \    'commands': ['Gista'],
        \    'mappings': '<Plug>(gista-',
        \    'unite_sources': 'gista',
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  " let g:gista#directory =
  " let g:gista#token_directory =
  " let g:gista#gist_entries_cache_directory =
  " let g:gista#gist_default_filename =
  " let g:gista#list_opener =
  " let g:gista#gist_openers =
  " let g:gista#gist_openers_in_action =
  " let g:gista#close_list_after_open =
  " let g:gista#auto_connect_after_post =
  " let g:gista#update_on_write =
  " let g:gista#enable_default_keymaps =
  " let g:gista#post_private =
  " let g:gista#interactive_description =
  " let g:gista#interactive_visibility =
  " let g:gista#include_invisible_buffer_in_multiple =
  " let g:gista#unite_smart_open_threshold =
  " let g:gista#gistid_yank_format =
  " let g:gista#gistid_yank_format_with_file =
  " let g:gista#gistid_yank_format_in_post =
  " let g:gista#gistid_yank_format_in_save =
  " let g:gista#default_yank_method =
  " let g:gista#auto_yank_after_post =
  " let g:gista#auto_yank_after_save =
  " let g:gista#disable_python_client =
  " let g:gista#suppress_acwrite_info_message =
  " let g:gista#suppress_not_owner_acwrite_info_message =
  " let g:gista#warn_in_partial_save =
  " let g:gista#get_with_authentication
  "}}}

  call neobundle#untap()
endif
" }}} "

" KazuakiM/vim-regexper {{{
if neobundle#tap('vim-regexper')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" itchyny/calendar.vim {{{
if neobundle#tap('calendar.vim')
  " Config {{{
  call neobundle#config( {
        \   'autoload' : {
        \       'commands' : 'Calendar'
        \}})
  "}}}

  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    augroup MyCalandarVim
      autocmd!
      autocmd FileType calendar :IndentGuidesDisable 
    augroup END
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" majutsushi/tagbar {{{
if neobundle#tap('tagbar')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" cohama/agit.vim {{{
if neobundle#tap('agit.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" moznion/github-commit-comment.vim {{{
if neobundle#tap('github-commit-comment.vim')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'depends' : ['jceb/vim-hier', 'dannyob/quickfixstatus']
        \})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}


  call neobundle#untap()
endif
" }}} "
"
" NeoBundle 'jaxbot/github-issues.vim'                      " Github issue lookup in Vim {{{
if neobundle#tap('github-issues.vim')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{

  "}}}

  call neobundle#untap()
endif
" }}}
" tejr/vim-tmux {{{
if neobundle#tap('vim-tmux')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" benmills/vimux {{{
if neobundle#tap('vimux')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" christoomey/vim-tmux-navigator {{{
if neobundle#tap('vim-tmux-navigator')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
    nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
  endfunction "}}}

  " Setting {{{
  let g:tmux_navigator_save_on_switch = 0
  let g:tmux_navigator_no_mappings = 0
  "}}}

  call neobundle#untap()
endif
" }}} "

" tpope/vim-fugitive'           {{{
if neobundle#tap('vim-fugitive')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    silent call ConfigOnGitRepository()
    augroup FUGITIVE
      autocmd!
      autocmd BufReadPost * silent call ConfigOnGitRepository()
    augroup END
  endfunction "}}}

  function! FugitiveMyMake() "{{{
    let l:error = system(&l:makeprg)
    redraw!
    " echohl Special 
    for error in split(l:error, '\n')
      echomsg error
    endfor
    " echohl None 
    execute 'call fugitive#cwindow()'
  endfunction "}}}


  " Setting {{{
  command! Make call FugitiveMyMake()

  function! ConfigOnGitRepository() "{{{
    if !exists('b:git_dir')
      return
    endif
    execute 'lcd '. fnamemodify(b:git_dir, ':p:h:h:gs? ?\\ ?')
    nnoremap <buffer> [git] <Nop>
    nmap <buffer> <Leader>g [git]
    nnoremap <buffer> [git]w :<C-u>Gwrite<CR>
    nnoremap <buffer> [git]c :<C-u>Gcommit<CR>
    nnoremap <buffer> [git]C :<C-u>Gcommit --amend<CR>
    nnoremap <buffer> [git]s :<C-u>Gstatus<CR>
    nnoremap <buffer> [git]d :<C-u>Gdiff<CR>
    nnoremap <buffer> [git]p :<C-u>Gpush<CR>
    " nnoremap <buffer> [git]P :<C-u>call MyGitPull()<CR>
    if &l:path !~# fnamemodify(b:git_dir, ':p:h:h:s? ?\\ ?')
      let &l:path .= ','.fnamemodify(b:git_dir, ':p:h:h:s? ?\\ ?')  
    endif
  endfunction "}}}
  "}}}

  call neobundle#untap()
endif
" }}} "Git操作用 プラグイン

" majutsushi/tagbar {{{
if neobundle#tap('tagbar')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  nnoremap <silent> ,q :TagbarToggle<CR>
  "}}}

  call neobundle#untap()
endif
" }}} "

" haya14busa/incsearch.vim {{{
if neobundle#tap('incsearch.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  " noremap <silent><expr> / incsearch#go({'command':'/','keymap':{'/':{'key':'\/','noremap':1}, ';' : {'key':'/;/', 'noremap':1}} })
  " noremap <silent><expr> ? incsearch#go({'command':'?','keymap':{'?':{'key':'\?','noremap':1}} })
  " map /  <Plug>(incsearch-forward)
  " map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  let g:incsearch#separate_highlight = 1
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)zz
  map N  <Plug>(incsearch-nohl-N)zz
  map *  <Plug>(incsearch-nohl-*)zz
  map #  <Plug>(incsearch-nohl-#)zz
  map g* <Plug>(incsearch-nohl-g*)zz
  map g# <Plug>(incsearch-nohl-g#)zz

  call neobundle#untap()
endif " }}} "
"}}}

" Lokaltog/vim-easymotion {{{
if neobundle#tap('vim-easymotion')
  " Config {{{
  " =======================================
  " Boost your productivity with EasyMotion
  " =======================================
  " Disable default mappings
  " If you are true vimmer, you should explicitly map keys by yourself.
  " Do not rely on default bidings.
  let g:EasyMotion_do_mapping = 0

  " Or map prefix key at least(Default: <Leader><Leader>)
  " map <Leader> <Plug>(easymotion-prefix)

  " =======================================
  " Find Motions
  " =======================================
  " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
  " `s{char}{char}{target}`
  " map <Leader>f <Plug>(easymotion-fl)
  " map <Leader>F <Plug>(easymotion-Fl)
  " map <Leader>t <Plug>(easymotion-tl)
  " map <Leader>T <Plug>(easymotion-Tl)
  nmap gs <Plug>(easymotion-s2)
  xmap gs <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  " Of course, you can map to any key you want such as `<Space>`
  " map <Space>(easymotion-s2)

  " Turn on case sensitive feature
  let g:EasyMotion_smartcase = 1

  " =======================================
  " Line Motions
  " =======================================
  " `JK` Motions: Extend line motions
  " map gj <Plug>(easymotion-j)
  " map gk <Plug>(easymotion-k)
  " keep cursor column with `JK` motions
  let g:EasyMotion_startofline = 0

  " =======================================
  " General Configuration
  " =======================================
  let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
  " Show target key with upper case to improve readability
  let g:EasyMotion_use_upper = 1
  " Jump to first match with enter & space
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  " =======================================
  " Search Motions
  " =======================================
  " Extend search motions with vital-over command line interface
  " Incremental highlight of all the matches
  " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
  " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
  " :h easymotion-command-line
  nmap g/ <Plug>(easymotion-sn)
  xmap g/ <Plug>(easymotion-sn)
  omap g/ <Plug>(easymotion-tn)
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" vim-jp/vimdoc-ja'         {{{
if neobundle#tap('vimdoc-ja')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} " ヘルプの日本語化

" mattn/learn-vimscript'    {{{
if neobundle#tap('learn-vimscript')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} " help for vim script

" vim-jp/vital.vim {{{
if neobundle#tap('vital.vim')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" uguu-org/vim-matrix-screensaver {{{
if neobundle#tap('vim-matrix-screensaver')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  "}}}

  call neobundle#untap()
endif
" }}} "

" tsukkee/lingr-vim {{{
if neobundle#tap('lingr-vim')
  " Config {{{
  call neobundle#config( {
        \ "lazy": 1,
        \ 'autoload' : {
        \   'commands' : ['Lingr']
        \}})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:lingr_vim_user = 'mnct.tkn3011@gmail.com'
  let g:lingr_vim_sidebar_width = 25 
  let g:lingr_vim_rooms_buffer_height = 10
  let g:lingr_vim_say_buffer_height = 3
  let g:lingr_vim_remain_height_to_auto_scroll = 5
  let g:lingr_vim_time_format     = '%c'
  let g:lingr_vim_command_to_open_url = 'firefox %s'

  function! s:notify(title, message)
    if has('unix') && s:executable('notify-send')
      let notify_cmd = 'notify-send %s %s'
    elseif has('windows')
      let notify_cmd = 'notify-send %s %s'
    elseif has('mac')
      let notify_cmd = 'growlnotify -t %s -m %s'
    else
    endif
    execute printf('silent !'. notify_cmd, shellescape(a:title, 1), shellescape(a:message, 1))
  endfunction

  augroup lingr-vim
    autocmd!
    " autocmd User WinEnter
    autocmd User plugin-lingr-message
          \   let s:temp = lingr#get_last_message()
          \|  if !empty(s:temp)
            \|      call s:notify(s:temp.nickname, s:temp.text)
            \|  endif
            \|  unlet s:temp

    autocmd User plugin-lingr-presence
          \   let s:temp = lingr#get_last_member()
          \|  if !empty(s:temp)
            \|      call s:notify(s:temp.name, (s:temp.presence ? 'online' : 'offline'))
            \|  endif
            \|  unlet s:temp
  augroup END

  "}}}

  call neobundle#untap()
endif
" }}} "

" TKNGUE/atcoder_helper {{{
if neobundle#tap('atcoder_helper')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:online_jadge_path = '/home/takeno/.local/src/OnlineJudgeHelper/oj.py'
  let g:atcoder_config = '/home/takeno/.local/src/OnlineJudgeHelper/setting.json'
  let g:atcoder_dir = '$HOME/Documents/codes/atcoder'
  "}}}

  call neobundle#untap()
endif
" }}} 

" TKNGUE/sum-it.vim {{{
if neobundle#tap('sum-it.vim')
  " Config {{{
  call neobundle#config( {})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}
  " Setting {{{
  "}}}
  call neobundle#untap()
endif
"}}}

" fuenor/im_control.vim {{{
if neobundle#tap('im_control.vim')
  " Config {{{
  call neobundle#config({
        \ 'external-commands' : 'python',
        \ })
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    " 「日本語入力固定モード」切替キー
    " inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
    " PythonによるIBus制御指定
    "バッファ毎に日本語入力固定モードの状態を制御。
    " let g:IM_CtrlBufLocalMode = 1
  endfunction "}}}

  " Setting {{{
  function! IMCtrl(cmd)
    let cmd = a:cmd
    if cmd == 'On'
      let res = system('ibus engine "mozc-jp"')
    elseif cmd == 'Off'
      let res = system('ibus engine "xkb:en::en"')
    endif
    return ''
  endfunction
  "}}}

  call neobundle#untap()
endif
" }}} "

" matchit.zip {{{
if neobundle#tap('matchit.zip')
  " Config {{{
  call neobundle#config({})
  "}}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}
  " Setting {{{
  "}}}
  call neobundle#untap()
endif
"}}} 

" thinca/vim-ref {{{
if neobundle#tap('vim-ref')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    augroup ref_vim
      autocmd!
      autocmd FileType ref-webdict call s:initialize_ref_viewer()
      autocmd FileType ref-man call s:initialize_ref_viewer()
    augroup END
    function! s:initialize_ref_viewer() "{{{
      nmap <buffer> b <Plug>(ref-back)
      nmap <buffer> f <Plug>(ref-forward)
      nnoremap <buffer> q <C-w>c
      setlocal nonumber
      " ... and more settings ...
    endfunction "}}}
    function! g:ref_source_webdict_sites.alc.filter(output) "{{{
      let l:output = substitute(a:output, "^.\\+_\\+", "", "")
      return "ALC dictoinary\n------------\n". join(split(l:output,'\n')[10:], "\n")
    endfunction "}}}
    function! g:ref_source_webdict_sites.weblio.filter(output) "{{{
      let l:output = substitute(a:output, '.\{-}から変更可能\n', '', "")
      " let l:output = substitute(l:output, '\n\n', '\n', "g")
      let l:output = substitute(l:output, '\s*\d\+\zs\n\+', '', "g")
      let l:output = substitute(l:output, '\s*\a\zs\n\+', '', "g")
      return "Weblio dictoinary\n------------\n".join(split(l:output,'\n'), "\n")
    endfunction "}}}
  endfunction "}}}

  " Setting {{{
  "Ref webdictでalcを使う設定
  let g:ref_no_default_key_mappings = 0
  " let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
  let g:ref_source_webdict_use_cache = 1
  let g:ref_source_webdict_sites = {
        \ 'alc' : {
        \   'url' : 'http://eow.alc.co.jp/%s/UTF-8/'
        \   },
        \ 'weblio' : {
        \   'url' : 'http://ejje.weblio.jp/content/%s/'
        \   }
        \ }
  let g:ref_source_webdict_sites['default'] = "weblio"
  let g:ref_detect_filetype=  {
        \ '_': ['man','webdict'],
        \ 'gitcommit': 'webdict',
        \ 'markdown': ['webdict', 'ALC'],
        \ 'c': 'man',
        \ 'clojure': 'clojure',
        \ 'perl': 'perldoc',
        \ 'php': 'phpmanual',
        \ 'ruby': 'refe',
        \ 'vim': '',
        \ 'cpp': 'man',
        \ 'tex': 'webdict',
        \ 'erlang': 'erlang',
        \ 'python': 'pydoc',
        \}
  "}}}

  call neobundle#untap()
endif
" }}}


" tyru/open-browser.vim {{{
if neobundle#tap('open-browser.vim')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'commands': ['OpenURL'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:openbrowser_search_engines = {
        \       'alc': 'http://eow.alc.co.jp/{query}/UTF-8/',
        \       'askubuntu': 'http://askubuntu.com/search?q={query}',
        \       'baidu': 'http://www.baidu.com/s?wd={query}&rsv_bp=0&rsv_spt=3&inputT=2478',
        \       'blekko': 'http://blekko.com/ws/+{query}',
        \       'cpan': 'http://search.cpan.org/search?query={query}',
        \       'devdocs': 'http://devdocs.io/#q={query}',
        \       'duckduckgo': 'http://duckduckgo.com/?q={query}',
        \       'github': 'http://github.com/search?q={query}',
        \       'google': 'http://google.com/search?q={query}',
        \       'google-scholar': 'https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0,5&q={query}',
        \       'google-code': 'http://code.google.com/intl/en/query/#q={query}',
        \       'php': 'http://php.net/{query}',
        \       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
        \       'twitter-search': 'http://twitter.com/search/{query}',
        \       'twitter-user': 'http://twitter.com/{query}',
        \       'verycd': 'http://www.verycd.com/search/entries/{query}',
        \       'vim': 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
        \       'wikipedia': 'http://en.wikipedia.org/wiki/{query}',
        \       'wikipedia-ja': 'http://ja.wikipedia.org/wiki/{query}',
        \       'yahoo': 'http://search.yahoo.com/search?p={query}',
        \}
  nmap gb <Plug>(openbrowser-smart-search)
  vmap gb <Plug>(openbrowser-smart-search)
  nmap gw :OpenBrowserSearch -wikipedia-ja <C-R><C-W><CR>
  nmap gs :OpenBrowserSearch -wikipedia-ja <C-R><C-W><CR>
  vmap gs :OpenBrowserSearch -goole-scholar <C-R><C-W><CR>
  "}}}

  call neobundle#untap()
endif
" }}}

" lilydjwg/colorizer {{{
if neobundle#tap('colorizer')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'commands' : ['ColorHighlight'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:colorizer_nomap = 1
  "}}}

  call neobundle#untap()
endif
" }}}

" thinca/vim-singleton {{{
if neobundle#tap('vim-singleton')

  " Config {{{
  call neobundle#config({
        \   'disable' : !has('clientserver'),
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    call singleton#enable()
  endfunction "}}}

  call neobundle#untap()
endif

" }}}

" osyo-mang/vim-precious {{{
if neobundle#tap('vim-precious')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'depends' : ['Shougo/context_filetype.vim'],
        \   'autoload' : {
        \     'filetypes' : ['markdown', 'help'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    augroup precious_aucmd
      autocmd!
      autocmd FileType markdown  nmap <buffer><leader>r  <Plug>(precious-quickrun-op)icx
    augroup END
    autocmd User PreciousFileType :echo precious#context_filetype()
  endfunction "}}}

  " Setting {{{
  let g:precious_enable_switchers = {
        \   "*" : {
        \     "setfiletype" : 0
        \   },
        \   "vim" : {
        \     "setfiletype" : 1
        \   },
        \   "markdown" : {
        \     "setfiletype" : 1
        \   },
        \}

  "}}}
  call neobundle#untap()
endif
" }}}

" mbbill/undotree {{{
if neobundle#tap('undotree')
  " Config {{{
  call neobundle#config({
        \   'lazy' : 1,
        \   'autoload' : {
        \     'commands' : ['UndotreeToggle'],
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    let g:undotree_WindowLayout=4 
    let g:undotree_SplitWidth=40
  endfunction "}}}

  " Setting {{{
  nnoremap U :UndotreeToggle<CR>
  "}}}

  call neobundle#untap()
endif
" }}}

" Shougo/context_filetype.vim {{{      
if neobundle#tap('context_filetype.vim')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  " Setting {{{
  let g:context_filetype#filetypes = {
        \ 'markdown': [
        \   {
        \     'start' : '^---$',
        \     'end' : '^...$',
        \     'filetype' : 'yaml',
        \   },
        \   {
        \    'start' : '^\s*```\s*\(\h\w*\)',
        \    'end' : '^\s*```$', 'filetype' : '\1',
        \   },
        \ ],
        \}
  "}}}

  call neobundle#untap()
endif
" }}}

" rhysd/github-complete.vim {{{
if neobundle#tap('github-complete.vim')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
    augroup config-github-complete
      autocmd!
      autocmd FileType gitcommit setl omnifunc=github_complete#complete
    augroup END

  endfunction "}}}

  " Setting {{{
  " let g:github_complete_enable_emoji_completion = 0
  " " let g:github_complete_enable_neocomplete = 1
  " let g:github_complete_emoji_japanese_workaround = 0
  "}}}

  call neobundle#untap()
endif
" }}}

" beloglazov/vim-online-thesaurus {{{
if neobundle#tap('vim-online-thesaurus')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  " let g:online_thesaurus_map_keys=0
  "}}}

  call neobundle#untap()
endif
" }}}
"}}}
"
" kana/vim-submode {{{
if neobundle#tap('vim-submode')
  " Config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'help',
        \     ],
        \   }
        \ })
  " }}}

  function! neobundle#tapped.hooks.on_source(bundle) "{{{
  endfunction "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle) "{{{
  endfunction "}}}

  " Setting {{{
  let g:submode_keep_leaving_key = 1
  function! s:SIDP()
    return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SIDP$') . '_'
  endfunction
  function! s:movetab(nr)
    execute 'tabmove' g:V.modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
  endfunction

  let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
  call submode#enter_with('movetab', 'n', '', '<Space>gt', printf(s:movetab, 1))
  call submode#enter_with('movetab', 'n', '', '<Space>gT', printf(s:movetab, -1))
  call submode#map('movetab', 'n', '', 't', printf(s:movetab, 1))
  call submode#map('movetab', 'n', '', 'T', printf(s:movetab, -1))
  unlet s:movetab

  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>-')
  call submode#map('winsize', 'n', '', '-', '<C-w>+')
  "}}}

  call neobundle#untap()
endif
" }}}"

" PLUGIN_SETTING_ENDPOINT
filetype plugin indent on
"}}}

" Local settings ================ {{{
let s:local_vimrc = expand('~/.local.vimrc')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif
" }}}

" Finally ======================={{{
" Installation check.
if !has('vim_starting')
  call neobundle#call_hook('on_source')
  call neobundle#call_hook('on_post_source')
endif
set secure
"}}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
