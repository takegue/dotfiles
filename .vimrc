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
  let g:python3_host_prog  = '/usr/local/bin/python3'
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
set belloff=error
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
  if has('mac')
    set clipboard=unnamed
  else
    set clipboard=unnamedplus,exclude:cons\|linux
  endif
endif

if has("persistent_undo")
  set undofile
  set undodir=~/.vim/.undodir
  set undolevels=500
endif

set directory=~/.vim/.swap
set nowritebackup
set nobackup
"}}}

" Mappings: {{{

let mapleader=" "
let maplocalleader='\'

nnoremap Q <nop>
nnoremap C  "_C
nnoremap G  Gzv

"For Breaking off undo sequence.
nnoremap & g&

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc>    :noh<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

function! OpenFolderOfCurrentFile() abort
  let l:path = shellescape(expand("%:p:h"),' ()')
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
cnoremap <C-a>  <Home>

" Toggle: {{{
nnoremap [toggle] <Nop>
nmap <Leader>o [toggle]
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

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

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
"}}}
"}}}

"Highlight: {{{
augroup my_higlight
  autocmd!
  autocmd ColorScheme * call s:additional_highlight()
  autocmd User VimrcReloaded call s:additional_highlight()
augroup END

function! s:additional_highlight()
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
function! s:executable(expr)
  let s:_executable[a:expr] = has_key(s:_executable, a:expr) ?
        \ s:_executable[a:expr] : executable(a:expr)
  return s:_executable[a:expr]
endfunction "}}}
"}}}

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

augroup my_diff_autocmd
  autocmd!
  autocmd  InsertLeave *
        \ if &diff | diffupdate | echo 'diff updated' | endif
augroup END

" Open junk file:{{{
command! -nargs=? -complete=filetype Memo call s:open_junk_file('<args>')
" command! Memo call s:Memo()
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
command! Todo call s:Todo()
function! s:Todo()
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
  autocmd BufNewFile,BufRead * if line('$') > 500 |
        \   set nonumber norelativenumber nocursorline lazyredraw |
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

function! s:RestoreCursorPostion()
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
  autocmd BufReadPost $MYVIMRC setlocal path+=$HOME/.vim/bundle
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
" dein.vim Initilization{{{
let g:noplugin = 0

" let g:bundle_root=  has('win32') || has('win64') ?
"       \ expand('~/vimfiles/bundle') : expand('~/.vim/bundle')
" let g:neobundle_root = g:bundle_root . '/neobundle.vim'

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  echon 'Installing dein.vim...'
  let dein_url = 'https://github.com/Shougo/dein.vim.git'
  call system('git clone '. dein_url . ' ' . shellescape(s:dein_repo_dir))
  echo 'done.'
  if v:shell_error
    echoerr 'dein.vim installation has failed!'
    finish
  endif
endif

if has('vim_starting')
  let &runtimepath = s:dein_repo_dir .",". &runtimepath
endif

function! s:loads_bundles() abort "{{{
  call dein#add('Shougo/dein.vim')

  " For author/plugin-name sort
  " :!LC_ALL=C sort -k2fd
  " For plugin-name/author sort
  " :!sort -k2fd
  "
  call dein#add('Shougo/vimproc.vim', {
        \ 'build': 'make'})

  call dein#add('alfredodeza/pytest.vim')
  call dein#add('AndrewRadev/switch.vim')
  call dein#add('basyura/unite-rails')
  call dein#add('beloglazov/vim-online-thesaurus')
  call dein#add('benmills/vimux')
  call dein#add('bps/vim-textobj-python')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('clones/vim-zsh')
  call dein#add('cohama/agit.vim')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('deris/vim-visualinc')
  call dein#add('deton/jasegment.vim')
  call dein#add('elzr/vim-json')
  call dein#add('emonkak/vim-operator-sort')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('fuenor/im_control.vim')
  call dein#add('hail2u/vim-css3-syntax')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/vim-migemo')
  call dein#add('honza/vim-snippets')
  call dein#add('hsanson/vim-android')
  call dein#add('ingydotnet/yaml-vim')
  call dein#add('itchyny/calendar.vim')
  call dein#add('itchyny/dictionary.vim')
  call dein#add('itchyny/lightline.vim', {
    \ 'depends': ['tpope/vim-fugitive', 'KazuakiM/vim-qfstatusline']
    \})
  call dein#add('jpo/vim-railscasts-theme')
  call dein#add('kana/vim-operator-replace')
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-smartchr')
  call dein#add('kana/vim-submode')
  call dein#add('kana/vim-textobj-datetime')
  call dein#add('kana/vim-textobj-entire')
  call dein#add('kana/vim-textobj-fold')
  call dein#add('kana/vim-textobj-function')
  call dein#add('kana/vim-textobj-user')
  call dein#add('KazuakiM/vim-qfstatusline')
  call dein#add('KazuakiM/vim-regexper')
  call dein#add('klen/python-mode')
  call dein#add('koron/codic-vim')
  call dein#add('lambdalisue/vim-gista')
  call dein#add('lambdalisue/vim-pyenv')
  call dein#add('lervag/vimtex')
  call dein#add('lilydjwg/colorizer')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('majutsushi/tagbar')
  call dein#add('matchit.zip')
  call dein#add('mattn/benchvimrc-vim')
  call dein#add('mattn/emmet-vim')
  call dein#add('mattn/ginger-vim')
  call dein#add('mattn/learn-vimscript')
  call dein#add('mattn/unite-advent_calendar')
  call dein#add('mattn/vim-textobj-url')
  call dein#add('mattn/webapi-vim')
  call dein#add('mbbill/undotree')
  call dein#add('moznion/github-commit-comment.vim')
  call dein#add('mrkn/mrkn256.vim')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('nathanaelkane/vim-indent-guides', {
        \ })
  " call dein#add('ivanov/vim-ipython')
  " call dein#add('vim-scripts/css_color.vim')
  call dein#add('NLKNguyen/papercolor-theme')
  call dein#add('osyo-manga/shabadou.vim')
  call dein#add('osyo-manga/unite-fold')
  call dein#add('osyo-manga/vim-precious')
  call dein#add('osyo-manga/vim-watchdogs')
  call dein#add('othree/html5.vim')
  call dein#add('rbonvall/vim-textobj-latex')
  call dein#add('rcmdnk/vim-markdown')
  call dein#add('rhysd/github-complete.vim')
  call dein#add('rhysd/vim-grammarous')
  call dein#add('sgur/vim-textobj-parameter')
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neobundle-vim-recipes', {'lazy':1})
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neossh.vim')
  call dein#add('Shougo/unite-help')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('Shougo/vimshell')
  call dein#add('sjl/badwolf')
  call dein#add('stephpy/vim-yaml')
  call dein#add('suan/vim-instant-markdown')
  call dein#add('syngan/vim-vimlint')
  call dein#add('tacroe/unite-mark')
  call dein#add('tejr/vim-tmux')
  call dein#add('thinca/vim-github')
  call dein#add('thinca/vim-quickrun')
  call dein#add('thinca/vim-ref')
  call dein#add('thinca/vim-singleton')
  call dein#add('thinca/vim-template')
  call dein#add('thinca/vim-textobj-comment')
  call dein#add('thisivan/vim-ruby-matchit')
  call dein#add('TKNGUE/atcoder_helper')
  call dein#add('TKNGUE/hateblo.vim')
  call dein#add('TKNGUE/sum-it.vim')
  "call dein#add('TKNGUE/vim-reveal')
  call dein#add('tmhedberg/SimpylFold')
  call dein#add('tomasr/molokai')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('mhinz/vim-signify')
  call dein#add('tsukkee/lingr-vim')
  call dein#add('tsukkee/unite-tag')
  call dein#add('tyru/open-browser.vim')
  call dein#add('uguu-org/vim-matrix-screensaver')
  call dein#add('ujihisa/neco-look')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('vim-jp/vital.vim')
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('vim-scripts/Align')
  call dein#add('vim-scripts/CSS-one-line--multi-line-folding')
  call dein#add('xolox/vim-session')
  call dein#add('Rykka/InstantRst')
  call dein#add('Rykka/riv.vim')
  call dein#add('tpope/vim-sensible')
  " " call dein#add('jaxbot/github-issues.vim')
  " " call dein#add('osyo-manga/vim-over')
  " " call dein#add('Shougo/junkfile.vim')
  " " call dein#add('welle/targets.vim')
  
  "BUNDLE_ENDPOINT
endfunction "}}}

if !g:noplugin
  call dein#begin(s:dein_dir)
  call s:loads_bundles()
  call dein#end()
  call dein#save_state()
endif

" END dein.vim}}}

" }}}

"" Design Setting: {{{
"" nathanaelkane/vim-indent-guides {{{
"if dein#tap('vim-indent-guides')
"
"  " Setting {{{
"  let g:indent_guides_enable_on_vim_startup = 1
"  let g:indent_guides_auto_colors = 0
"  let g:indent_guides_start_level = 2
"  let g:indent_guides_guide_size = 1
"  let g:indent_guides_default_mapping = 1
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" itchyny/lightline.vim {{{
"if dein#tap('lightline.vim')
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    augroup LightLineColorscheme
"      autocmd!
"      autocmd ColorScheme * call s:lightline_update()
"    augroup END
"    augroup LightLineStatus
"      autocmd!
"      autocmd BufRead * if exists('fugitive_branch') | :unlet b:fugitive_branch | endif
"      autocmd User vim-pyenv-activate-post if exists('b:pyenv_version') | :unlet b:pyenv_version | endif
"    augroup END
"  endfunction "}}}
"
"  function! s:lightline_update()
"    if !exists('g:loaded_lightline')
"      return
"    endif
"    try
"      if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow\|PaperColor'
"        let g:lightline.colorscheme =
"              \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
"              \ (g:colors_name ==# 'solarized\|PaperColor' ? '_' . &background : '')
"        call lightline#init()
"        call lightline#colorscheme()
"        call lightline#update()
"      endif
"    catch
"    endtry
"  endfunction"}}}
"
"  " Setting {{{
"
"  " Functions {{{
"  function! MyModified()
"    return &ft =~ 'help\|vimfiler\|gundo' || &bt == 'nofile' || &previewwindow ?
"          \ '' : &modified ? '+' : &modifiable ? '' : '-'
"  endfunction
"
"  function! MyReadonly()
"    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ?  '⭤' : ''
"  endfunction
"
"  function! MyFilename()
"    let fname = expand('%:t')
"    if fname =~ '^lingr-'
"      let fname = '['. fname . ']'
"    elseif fname == ''
"      let fname = '[No Name]'
"    endif
"    let b:lightline_filename = ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
"          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
"          \  &ft == 'unite'    ? unite#get_status_string()    :
"          \  &ft == 'vimshell' ? vimshell#get_status_string() :
"          \  &previewwindow    ? '[Preview]':
"          \  &bt == 'quickfix' ? '[Quick Fix]'                :
"          \  &bt == 'help'     ? '[Help]'                     :
"          \  fname =~ '^['     ?  fname                       :
"          \  &bt == 'nofile' && &bh =='hide'  ? '[Scratch]'   :
"          \  fname) .
"          \ ('' != MyModified() ? ' ' . MyModified() : '')
"    return b:lightline_filename
"  endfunction "}}}
"
"  function! MyPyenv()
"    if &ft =~ 'python'
"      if !exists('b:pyenv_version')
"        let statusline = pyenv#info#format('%av')
"        let b:pyenv_version = statusline
"      endif
"      return b:pyenv_version
"    else
"      return ''
"    endif
"  endfunction "}}}
"
"  function! MyFugitive()
"    if exists('b:git_dir')
"      if !exists('b:fugitive_branch')
"        let statusline = fugitive#statusline()
"        let b:fugitive_branch = substitute(statusline, '\[Git(\(.\+\))\]', '⭠ \1', '')
"      endif
"      return b:fugitive_branch
"    else
"      return ''
"    endif
"  endfunction "}}}
"
"  function! MyFileformat()
"    return winwidth(0) > 70 ? &fileformat : ''
"  endfunction
"  function! MyFiletype()
"    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
"  endfunction
"  function! MyFileencoding()
"    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
"  endfunction
"
"  function! MyCount()
"    if mode() =~ '[vV]\|CTRL-V\|'
"      return sumit#count_selected_text()
"    else
"      return ''
"    endif
"  endfunction
"  function! MyMode()
"    return winwidth(0) > 60 ? lightline#mode() :lightline#mode()[00]
"  endfunction
"  "}}}
"
"  let g:lightline = {
"        \ 'colorscheme': 'solarized',
"        \ 'mode_map': {'c': 'COMMAND'},
"        \ 'active': {
"        \   'left':  [ [ 'mode', 'paste' ], ['fugitive', 'pyenv', 'rubyenv'], ['filename'] ],
"        \   'right': [ [ 'lineinfo' ],
"        \              [ 'percent' ],
"        \              [ 'fileformat', 'fileencoding', 'filetype' ],
"        \              [ 'count'], ],
"        \ },
"        \ 'component': {
"        \   'lineinfo': '%3l:%-2v',
"        \ },
"        \ 'component_expand': {
"        \   'syntaxcheck': 'qfstatusline#Update',
"        \ },
"        \ 'component_type': {
"        \   'syntaxcheck': 'error',
"        \ },
"        \ 'component_function': {
"        \   'syntaxcheck': 'qfstatusline#Update',
"        \   'modified': 'MyModified',
"        \   'readonly': 'MyReadonly',
"        \   'fugitive': 'MyFugitive',
"        \   'count': 'MyCount',
"        \   'pyenv': 'MyPyenv',
"        \   'filename': 'MyFilename',
"        \   'fileformat': 'MyFileformat',
"        \   'filetype': 'MyFiletype',
"        \   'fileencoding': 'MyFileencoding',
"        \   'mode': 'MyMode'
"        \ },
"        \ 'component_visible_condition' :{
"        \   'modified': '&modified||!&modifiable',
"        \   'readonly': '&readonly'
"        \ },
"        \ 'separator': { 'left': '⮀', 'right': '⮂' },
"        \ 'subseparator': { 'left': '⮁', 'right': '⮃' }}
"
"  " :WatchdogsRun後にlightline.vimを更新
"  let g:Qfstatusline#UpdateCmd = function('lightline#update')
"  let g:Qfstatusline#Text      = 0
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" }}}
"
"" Editing Auxiliary Settings:{{{
"" rhysd/vim-grammarous {{{
"if dein#tap('vim-grammarous')
"  " Config {{{
"  call dein#config( {
"        \     'on_cmd' : [
"        \       'GrammarousCheck',
"        \     ],
"        \     'mappings' : [
"        \       '<Plug>',
"        \     ],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" ujihisa/neco-look {{{
"if dein#tap('neco-look')
"  " Config {{{
"  call dein#config({
"        \ 'depends' : ['neocomplete.vim']
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" koron/codic-vim {{{
"if dein#tap('codic-vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" deris/vim-visualinc {{{
"if dein#tap('vim-visualinc')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" mattn/ginger-vim {{{
"if dein#tap('ginger-vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" Shougo/neocomplete.vim {{{
"if dein#tap('neocomplete.vim')
"  " Config {{{
"  call dein#config({
"        \ 'lazy' : 1,
"        \ 'disabled' : "!has('lua') || has('nvim')
"        \ 'vim_version' : '7.3.885',
"        \  'insert' : 1,
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    " Plugin key-mappings.
"    " inoremap <expr><C-g>     neocomplete#undo_completion()
"    " inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"    " Recommended key-mappings.
"    " <CR>: close popup and save indent.
"    function! s:my_cr_function()
"      " return neocomplete#close_popup() . "\<CR>"
"      "For no inserting <CR> key.
"      return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"    endfunction
"    " <TAB>: completion.
"    " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"    " For smart TAB completion.
"    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"          \ <SID>check_back_space() ? "\<TAB>" :
"          \ neocomplete#start_manual_complete()
"
"    function! s:check_back_space()
"      let col = col('.') - 1
"      return !col || getline('.')[col - 1]  =~ '\s'
"    endfunction "}}}
"
"    " <C-h>, <BS>: close popup and delete backword char.
"    if dein#is_installed('neosnippet.vim')
"      inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"      " For cursor moving in insert mode(Not recommended)
"      inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"      inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"      inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"      inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"      " make neocomplcache use jedi#completions omini function for python scripts
"
"      augroup tex_complete
"        autocmd!
"        autocmd FileType *.tex inoremap <expr>$$ $$<left>
"      augroup END
"
"      " Plugin key-mappings.
"      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      xmap <C-k>     <Plug>(neosnippet_expand_target)
"      xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)
"
"      " SuperTab like snippets behavior.
"      imap <expr><CR>  neosnippet#expandable() ?
"            \ "\<Plug>(neosnippet_expand)
"            \ pumvisible() ?  "\<C-Y>".neocomplete#close_popup(): "\<CR>"
"
"      " <TAB>: completion.
"      " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"      " inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"
"      " Plugin key-mappings.
"      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"
"      " SuperTab like snippets behavior.
"      imap <expr><TAB> neosnippet#jumpable() ?
"            \ pumvisible() ? "\<C-n>" : "\<Plug>(neosnippet_jump_or_expand)
"            \ pumvisible() ? "\<C-n>" : "\<TAB>"
"      smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)
"    endif
"    "}}}
"  endfunction "}}}
"
"  " Setting {{{
"  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"  " Disable AutoComplPop.
"  let g:acp_enableAtStartup = 0
"  " Use neocomplete.
"  let g:neocomplete#text_mode_filetypes= {
"        \ 'tex' : 1,
"        \ 'plaintex' : 1,
"        \ 'gitcommit' : 1
"        \}
"  if !has('nvim')
"    let g:neocomplete#enable_at_startup = 1
"  endif
"  " Use smartcase.
"  let g:neocomplete#enable_smart_case = 1
"  " Set minimum syntax keyword length.
"  let g:neocomplete#sources#syntax#min_keyword_length = 3
"  let g:neocomplete#max_keyword_width = 50
"  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"  let g:neocomplete#enable_auto_delimiter = 0
"  let g:neocomplete#enable_auto_close_preview = 0
"  let g:neocomplete#auto_completion_start_length  = 3
"  let g:neocomplete#skip_auto_completion_time  = "0.2"
"  " Define dictionary.
"  let g:neocomplete#sources#dictionary#dictionaries = {
"        \ 'default' : '',
"        \ 'vimshell' : $HOME.'/.vimshell_hist',
"        \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"
"  let g:neocomplete#enable_multibyte_completion = 1
"
"  " make Vim call omni function when below patterns matchs
"  " let g:neocomplete#sources#omni#functions = {}
"
"  let g:neocomplete#force_omni_input_patterns = {}
"  let g:neocomplete#force_omni_input_patterns.python =
"        \ '\%([^. \t]\{1,}\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"
"  " let g:neocomplete#sources#omni#input_patterns = {}
"  " let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"  " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"  " let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"  " let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"  " if !exists('g:neocomplete#keyword_patterns')
"  "   let g:neocomplete#keyword_patterns = {}
"  " endif
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
""
"" Shougo/deoplete.nvim {{{
"if dein#tap('deoplete.nvim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'disabled' : !has('nvim'),
"        \   'on_i' : 1,
"        \   'on_unite' : [
"        \     'help',
"        \    ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    set completeopt-=preview
"    " <C-h>, <BS>: close popup and delete backword char.
"    inoremap <expr><C-h> deoplete#mappings#smart_close_popup(). "\<C-h>"
"    inoremap <expr><BS>  deoplete#mappings#smart_close_popup(). "\<C-h>"
"
"    " Plugin key-mappings.
"    " inoremap <expr><C-g>     deoplete#undo_completion()
"    inoremap <expr><C-l>     deoplete#complete_common_string()
"
"    " Recommended key-mappings.
"    " <CR>: close popup and save indent.
"    function! s:my_cr_function()
"      " return deoplete#close_popup() . "\<CR>"
"      "For no inserting <CR> key.
"      return pumvisible() ? deoplete#mappings#smart_close_popup() : "\<CR>"
"    endfunction
"
"    " SuperTab like snippets behavior.
"    imap <expr><CR>  neosnippet#expandable() ?
"          \ "\<Plug>(neosnippet_expand)
"          \ pumvisible() ?  "\<C-Y>".neocomplete#close_popup(): "\<CR>"
"
"    " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"    " For smart TAB completion.
"    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"          \ <SID>check_back_space() ? "\<TAB>" :
"          \ deoplete#start_manual_complete()
"
"    function! s:check_back_space()
"      let col = col('.') - 1
"      return !col || getline('.')[col - 1]  =~ '\s'
"    endfunction "}}}
"
"    " <C-h>, <BS>: close popup and delete backword char.
"    if dein#is_installed('neosnippet.vim')
"      " For cursor moving in insert mode(Not recommended)
"      inoremap <expr><Left>  deoplete#mappings#close_popup() . "\<Left>"
"      inoremap <expr><Right> deoplete#mappings#close_popup() . "\<Right>"
"      inoremap <expr><Up>    deoplete#mappings#close_popup() . "\<Up>"
"      inoremap <expr><Down>  deoplete#mappings#close_popup() . "\<Down>"
"      " make neocomplcache use jedi#completions omini function for python scripts
"
"      augroup tex_complete
"        autocmd!
"        autocmd FileType *.tex inoremap <expr>$$ $$<left>
"      augroup END
"
"      " Plugin key-mappings.
"      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      xmap <C-k>     <Plug>(neosnippet_expand_target)
"      xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)
"
"      " SuperTab like snippets behavior.
"      imap <expr><CR>  neosnippet#expandable() ?
"            \ "\<Plug>(neosnippet_expand)
"            \ pumvisible() ?  "\<C-Y>".deoplete#mappings#close_popup(): "\<CR>"
"
"      " <TAB>: completion.
"      " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"      " inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"
"      " Plugin key-mappings.
"      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"
"      " SuperTab like snippets behavior.
"      imap <expr><TAB> neosnippet#jumpable() ?
"            \ pumvisible() ? "\<C-n>" : "\<Plug>(neosnippet_jump_or_expand)
"            \ pumvisible() ? "\<C-n>" : "\<TAB>"
"      smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)
"    endif
"    "}}}
"
"  endfunction "}}}
"
"  " Setting {{{
"  " Use deoplete.
"  if has('nvim')
"    let g:deoplete#enable_at_startup = 1
"    " Use smartcase.
"    let g:deoplete#enable_smart_case = 1
"
"    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"    let g:acp_enableAtStartup = 0
"    " Use neocomplete.
"    let g:deoplete#text_mode_filetypes= {
"          \ 'tex' : 1,
"          \ 'plaintex' : 1,
"          \ 'gitcommit' : 1
"          \}
"    " Use smartcase.
"    let g:deoplete#enable_smart_case = 1
"    " Set minimum syntax keyword length.
"    let g:deoplete#sources#syntax#min_keyword_length = 3
"    let g:deoplete#max_keyword_width = 50
"    let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
"    let g:deoplete#enable_auto_delimiter = 0
"    let g:deoplete#enable_auto_close_preview = 0
"    let g:deoplete#auto_completion_start_length  = 3
"    let g:deoplete#skip_auto_completion_time  = "0.2"
"    " Define dictionary.
"    let g:deoplete#sources#dictionary#dictionaries = {
"          \ 'default' : '',
"          \ 'vimshell' : $HOME.'/.vimshell_hist',
"          \ 'scheme' : $HOME.'/.gosh_completions'
"          \ }
"
"    let g:deoplete#enable_multibyte_completion = 1
"
"    " make Vim call omni function when below patterns matchs
"    " let g:deoplete#sources#omni#functions = {}
"
"    let g:deoplete#omni#input_patterns = {}
"    let g:deoplete#omni#input_patterns.python = ['\s*from\s+\w*', 'import\s+\w*', '\S{2,}\.']
"    " \ '\%([^. \t]\{1,}\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import\)\w*'
"
"    " let g:deoplete#sources#omni#input_patterns = {}
"    " let g:deoplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"    " let g:deoplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"    " let g:deoplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"    " let g:deoplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"    " if !exists('g:deoplete#keyword_patterns')
"    "   let g:deoplete#keyword_patterns = {}
"    " endif
"    "}}}
"  endif
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" Shougo/neosnippet.vim {{{
"if dein#tap('neosnippet.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy'  : 1 ,
"        \   'on_i'  : 1,
"        \   'on_unite' : [
"        \     'snippet', 'neosnippet/user', 'neosnippet/runtime', 'help'
"        \     ],
"        \ })
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"
"    augroup neosnippet_setting
"      autocmd!
"      autocmd InsertLeave * NeoSnippetClearMarkers
"    augroup END
"
"    " For snippet_complete marker.
"    if has('conceal')
"      set conceallevel=0 concealcursor=nivc
"    endif
"  endfunction "}}}
"
"  " Setting {{{
"
"  " Enable snipMate compatibility feature.
"  let g:neosnippet#enable_snipmate_compatibility = 1
"  let g:neosnippet#snippets_directory = ['~/.vim/bundle/vim-snippets/snippets','~/.vim/snippets']
"  let g:neosnippet#enable_preview = 0
"
"  " inoremap <expr>{} "{}\<\`0\`><C-O>F}"
"  " inoremap <expr>()
"  " inoremap <expr>[] "[]\<\`0\`><C-O>F]"
"  " inoremap <expr><> "<>\<\`0\`><C-O>F>"
"  " inoremap <expr>'' "''\<\`0\`><C-O>F'"
"  " inoremap <expr>`` "``\<\`0\`><C-O>3F`"
"  " inoremap <expr>"" "\"\"\<\`0\`><C-O>F\""
"
"  " }}}
"  call dein#untap()
"endif "}}}
"
"" Shougo/neosnippet-snippets {{{
"if dein#tap('neosnippet-snippets')
"  " Config {{{
"  call dein#config({
"        \     'insert' : 1,
"        \     'on_ft' : 'neosnippet',
"        \     'on_unite' : [
"        \           'snippet',
"        \           'neosnippet/user',
"        \           'neosnippet/runtime'
"        \       ],
"        \ })
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" honza/vim-snippets {{{
"if dein#tap('vim-snippets')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" haya14busa/vim-migemo {{{
"if dein#tap('vim-migemo')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \})
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"" }}}
"
"" Vim Operator Settings: {{{
"
"" kana/vim-operator-user {{{
"if dein#tap('vim-operator-user')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" kana/vim-operator-replace {{{
"if dein#tap('vim-operator-replace')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    map _ <Plug>(operator-replace)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tpope/vim-commentary'                         {{{
"if dein#tap('vim-commentary')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "コメント切り替えオペレータ
"
"" tpope/vim-repeat {{{
"if dein#tap('vim-repeat')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tpope/vim-unimpaired'                         {{{
"if dein#tap('vim-unimpaired')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "バッファ移動用等
"
"" emonkak/vim-operator-sort {{{
"if dein#tap('vim-operator-sort')
"  " Config {{{
"  call dein#config( {
"        \ 'depends' : ['tpope/vim-operator-user']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" pekepeke/vim-operator-tabular {{{
"if dein#tap('vim-operator-tabular')
"  " Config {{{
"  call dein#config( {
"        \ 'depends' : ['pekepeke/vim-csvutil']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" wellle/targets.vim {{{
"if dein#tap('targets.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" AndrewRadev/switch.vim                            {{{
"if dein#tap('switch.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    augroup switch_autocmd
"      autocmd FileType gitrebase let b:switch_custom_definitions = [
"            \ ['pick' , 'reword', 'edit'  , 'squash' , 'fixup' , 'exec'],
"            \]
"      autocmd FileType python let g:switch_custom_definitions =
"            \[
"            \   ['and', 'or'],
"            \   {
"            \     '\(.\+\) if \(.\+\) else \(.\+\)' : {
"            \        '\(\s*\)\(.\+\) = \(.\+\) if \(.\+\) else \(.\+\)' :
"            \             '\1if \4:\1    \2 = \3\1else:\1    \2 = \5'
"            \      }
"            \   },
"            \]
"    augroup END
"
"    let g:switch_custom_definitions = [
"          \   ['TRUE', 'FALSE'], ['True', 'False'], ['true', 'false'],
"          \   ['ENABLE', 'DISABLE'], ['Enable', 'Disable'], ['enable', 'disable'],
"          \   ['!=', '=='],
"          \   {
"          \     '>\(=\)\@!'  : '>=',
"          \     '>='  : '<',
"          \     '<\(=\)\@!'  : '<=',
"          \     '<='  : '>',
"          \   },
"          \   {
"          \     '\<[a-z0-9]\+_\k\+\>': {
"          \       '_\(.\)': '\U\1',
"          \       '\<\(.\)': '\U\1'
"          \     },
"          \     '\<[A-Za-z][a-z0-9]\+[A-Z]\k\+\>': {
"          \       '\(\u\)': '_\l\1',
"          \       '\<_': ''
"          \     },
"          \   }
"          \ ]
"    let g:switch_increment_definitions = []
"    let g:switch_decrement_definitions = []
"  endfunction "}}}
"
"  let g:switch_mapping = "-"
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "true ⇔ falseなどの切り替え
"
"" Text Object Settings: {{{
"" kana/vim-operator-fold {{{
"if dein#tap('vim-textobj-fold')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
""}}}
"" kana/vim-textobj-user {{{
"if dein#tap('vim-textobj-user')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" sgur/vim-textobj-parameter'                   {{{
"if dein#tap('vim-textobj-parameter')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "引数オブジェクト #a, i,
"
"" kana/vim-textobj-entire"                      {{{
"if dein#tap('vim-textobj-entire')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "全体選択オブジェクト   #ae, ai
"
"" kana/vim-textobj-datetime"                    {{{
"if dein#tap('vim-textobj-datetime')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "日付選択オブジェクト   #ada, add, adt
"
"" thinca/vim-textobj-comment"                   {{{
"if dein#tap('vim-textobj-comment')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "コメントオブジェクト   #ac, ic×
"
"" mattn/vim-textobj-url"                        {{{
"if dein#tap('vim-textobj-url')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "URLオブジェクト        #au, iu
"
"" rbonvall/vim-textobj-latex                   {{{
"if dein#tap('vim-textobj-latex')
"  " Config {{{
"  call dein#config({
"        \ 'lazy' : 1,
"        \ 'on_ft' : ['tex'],
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "LaTeXオブジェクト      #\, $ q, Q, e
"
"" kana/vim-textobj-function {{{
"if dein#tap('vim-textobj-function')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \ 'script_ytype' : 'ftplugin',
"        \   'on_ft' : ['cpp', 'java', 'vim']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" bps/vim-textobj-python {{{
"if dein#tap('vim-textobj-python')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \ 'script_ytype' : 'ftplugin',
"        \   'on_ft' : ['python', 'pytest']
"        \})
"  "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" michaeljsmith/vim-indent-object'              {{{
"if dein#tap('vim-indent-object')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "同Indentオブジェクト   #ai. ii, aI, iI
"" }}}
"
"" Programming Tools Settings: {{{
"
"" Programming Utilities: {{{
""
"" thinca/vim-quickrun {{{
"if dein#tap('vim-quickrun')
"  " Config {{{
"  call dein#config({
"        \ 'on_cmd' : [
"        \       'QuickRun',
"        \  ],
"        \'depends' : ['Shougo/vimproc.vim', 'shabadou.vim']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    nnoremap <silent> <Leader>r :QuickRun<CR>
"    nnoremap <silent><expr> <Leader>d eval('":QuickRun <". b:input_file . "<CR>"')
"    nnoremap <silent> <Leader>se :QuickRun sql<CR>
"  endfunction "}}}
"
"  " Setting {{{
"  let g:quickrun_config = {
"        \ "_": {
"        \   "hook/my_anime/enable" : 1,
"        \   "hook/my_anime/wait" : 2,
"        \   "hook/qfsigns_update/enable_exit":   1,
"        \   "hook/qfsigns_update/priority_exit": 3,
"        \   "hook/qfstatusline_update/enable_exit" : 1,
"        \   "hook/qfstatusline_update/priority_exit" : 4,
"        \   "runner"                   : 'vimproc',
"        \   "runner/vimproc/read_timeout" : 100,
"        \   "runner/vimproc/sleep"      : 100,
"        \   "runner/vimproc/updatetime" : 100,
"        \   "outputter/buffer/split"    : 'bot %{winwidth(0) * 2 > winheight(0) * 5 ? "vertical" : ""}',
"        \},
"        \   "watchdogs_checker/_" : {
"        \      "hook/close_quickfix/enable_exit" : 1,
"        \      "runner/vimproc/updatetime" : 1000,
"        \}}
"  let g:quickrun_config.sql ={
"        \ 'command' : 'mysql',
"        \ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
"        \ 'exec'    : ['%c %o < %s' ] ,
"        \}
"  let g:quickrun_config['php.unit'] = {
"        \ 'command': 'testrunner',
"        \ 'cmdopt': 'phpunit'
"        \}
"  let g:quickrun_config['python'] = {
"        \ 'command': 'python',
"        \}
"  let g:quickrun_config['python/watchdogs_checker'] = {
"        \  "type" : "watchdogs_checker/flake8",
"        \}
"  let g:quickrun_config['python.pytest'] = {
"        \ 'command': 'py.test',
"        \ 'cmdopt': '-v'
"        \}
"  let g:quickrun_config.markdown  = {
"        \ 'type' : 'markdown/pandoc',
"        \ 'cmdopt': '-v -s -mathjax -f markdown -t html',
"        \ 'outputter' : 'browser'
"        \ }
"  let g:quickrun_config.html  = {
"        \ 'command' : 'cygstart',
"        \ 'cmdopt'  : '%c %o' ,
"        \ 'outputter' : 'browser'
"        \ }
"  let g:quickrun_config['ruby.rspec']  = {
"        \ 'command': 'rspec'
"        \ , 'cmdopt': '-f d'
"        \ }
"
"
"  function! MakeMySQLCommandOptions()
"    if !exists("g:mysql_config_usr")
"      let g:mysql_config_user = input("user> ")
"    endif
"    if !exists("g:mysql_config_host")
"      let g:mysql_config_host = input("host> ")
"    endif
"    if !exists("g:mysql_config_port")
"      let g:mysql_config_port = input("port> ")
"    endif
"    if !exists("g:mysql_config_pass")
"      let g:mysql_config_pass = inputsecret("password> ")
"    endif
"    if !exists("g:mysql_config_db")
"      let g:mysql_config_db = input("database> ")
"    endif
"
"    let optlist = []
"    if g:mysql_config_user != ''
"      call add(optlist, '-u ' . g:mysql_config_user)
"    endif
"    if g:mysql_config_host != ''
"      call add(optlist, '-h ' . g:mysql_config_host)
"    endif
"    if g:mysql_config_db != ''
"      call add(optlist, '-D ' . g:mysql_config_db)
"    endif
"    if g:mysql_config_pass != ''
"      call add(optlist, '-p' . g:mysql_config_pass)
"    endif
"    if g:mysql_config_port != ''
"      call add(optlist, '-P ' . g:mysql_config_port)
"    endif
"    if exists("g:mysql_config_otheropts")
"      call add(optlist, g:mysql_config_otheropts)
"    endif
"    return join(optlist, ' ')
"  endfunction
"
"  augroup QuickRunUnitTest
"    autocmd!
"    autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
"    "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
"    autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
"    autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
"    autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
"  augroup END
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" osyo-manga/vim-watchdogs {{{
"if dein#tap('vim-watchdogs')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \    'on_unite' : [
"        \       'help',
"        \     ],
"        \    'on_cmd' : [
"        \       {
"        \         'name' : 'WatchdogsRun',
"        \         'complete' : 'customlist,quickrun#complete'
"        \       },
"        \     ],
"        \   'depends' : ['thinca/vim-quickrun', 'Shougo/vimproc.vim', 'osyo-manga/shabadou.vim',
"        \       'jceb/vim-hier', 'dannyob/quickfixstatus', 'KazuakiM/vim-qfsigns',
"        \    ]
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:watchdogs_check_BufWritePost_enables = {
"        \   "cpp"     : 1,
"        \   "python"  : 0,
"        \   "ruby"    : 1,
"        \   "haskell" : 1,
"        \}
"
"  let g:watchdogs_check_CursorHold_enables = {
"        \   "cpp"     : 1,
"        \   "python"  : 0,
"        \   "ruby"    : 1,
"        \   "haskell" : 1,
"        \}
"  let g:watchdogs_check_BufWritePost_enable_on_wq = 0
"  "}}}
"  call dein#untap()
"endif
"" }}}
"
""}}}
"
"" Ruby: {{{
"" tpope/vim-rails {{{
"if dein#tap('vim-rails')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" thisivan/vim-ruby-matchit {{{
"if dein#tap('vim-ruby-matchit')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'on_ft': ['ruby'],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" vim-ruby/vim-ruby {{{
"if dein#tap('vim-ruby')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \ "on_ft" : ["ruby"],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
""}}}
"
"" Python: {{{
"" alfredodeza/pytest.vim {{{
"if dein#tap('pytest.vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \ 'external-commands' : ['pytest'],
"        \ 'on_ft' : ['python', 'python3', 'pytest'],
"        \ 'build'       : {
"        \   "cygwin"    : "pip install --user pytest",
"        \   "mac"       : "pip install --user pytest",
"        \   "unix"      : "pip install --user pytest"
"        \}})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    nnoremap  <silent><F5>      <Esc>:Pytest file verbose<CR>
"    nnoremap  <silent><C-F5>    <Esc>:Pytest class verbose<CR>
"    nnoremap  <silent><S-F5>    <Esc>:Pytest project verbose<CR>
"    nnoremap  <silent><F6>      <Esc>:Pytest session<CR>
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
""
"" voithos/vim-python-matchit {{{
"if dein#tap('vim-python-matchit')
"  " Config {{{
"  call dein#config( {
"        \ "lazy"    : 1,
"        \   "on_ft" : ["python", "python3", "djangohtml"]
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" klen/python-mode {{{
"if dein#tap('python-mode')
"  " Config {{{
"  call dein#config( {
"        \ 'lazy' : 1,
"        \ 'external_commands' : ['pyflakes', 'pylint'],
"        \ "disable"    : !has('python'),
"        \ "on_ft" : ["python", "python3", "djangohtml"],
"        \ "build_commands"  : ['pip'],
"        \ "build"       : {
"        \   "cygwin"    : "pip install --user pylint rope pyflakes pep8",
"        \   "mac"       : "pip install --user pylint rope pyflakes pep8",
"        \   "unix"      : "pip install --user pylint rope pyflakes pep8"
"        \ }})
"  "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    nnoremap <silent><F8> :<C-u>PymodeLintAuto<CR>
"    nnoremap <silent><expr><leader>R  ":<C-u>VimShellInteractive --split='bot split \| resize 20' python ". expand('%').'<CR>'
"
"    augroup pymode_myautocmd
"      autocmd!
"      autocmd BufEnter '__doc__' nnoremap <buffer>q  <C-w>c
"      autocmd BufEnter '__doc__' normal zr
"      autocmd BufReadPost '__doc__' normal zr
"      autocmd BufEnter __doc____rope__ nnoremap <buffer>q  <C-w>c
"    augroup END
"  endfunction "}}}
"
"  " Setting {{{
"  let g:pymode = 1
"  let g:pymode_warnings = 1
"  " let g:pymode_paths = ['shutil', 'datetime', 'time',
"  "       \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
"  let g:pymode_trim_whitespaces = 1
"  let g:pymode_options = 1
"  let g:pymode_options_colorcolumn = 1
"  let g:pymode_quickfix_minheight = 3
"  let g:pymode_quickfix_maxheight = 6
"  let g:pymode_python = 'python'
"  " let g:pymode_indent = []
"  let g:pymode_folding = 1
"  let g:pymode_motion = 1
"
"  let g:pymode_doc = 1
"  let g:pymode_doc_bind = 'K'
"  let g:jedi#goto_command = 'gd'
"  let g:pymode_virtualenv = 0
"  let g:pymode_virtualenv_path = $PYENV_ROOT. "/versions"
"
"  let g:pymode_run = 0            "QuickRunの方が優秀
"  " let g:pymode_run_bind = '<leader>R'
"
"  let g:pymode_breakpoint = 1
"  let g:pymode_breakpoint_bind = '<leader>b'
"
"  let g:pymode_lint = 1
"  let g:pymode_lint_on_write = 1
"
"  "Check code on every save (every)
"  let g:pymode_lint_unmodified = 0
"  let g:pymode_lint_on_fly = 0
"  let g:pymode_lint_message = 1
"  " let g:pymode_lint_ignore = "E501,W"
"  " let g:pymode_lint_select = "E501,W0011,W430"
"  let g:pymode_lint_cwindow = 1
"
"  let g:pymode_rope = 0
"  let g:pymode_rope_autoimport = 0
"  " let g:pymode_rope_autoimport_modules = ['shutil', 'datetime', 'time',
"  "             \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
"  " let g:pymode_rope_autoimport_import_after_complete = 0
"  " let g:pymode_rope_organize_imports_bind = '<F11>'
"
"  " let g:pymode_rope_goto_definition_bind = 'gf'
"  " " let g:pymode_rope_goto_definition_cmd = 'botrightn new'
"
"  " let g:pymode_rope_rename_bind = 'R'
"  " " let g:pymode_rope_rename_module_bind = '<C-S-R>'
"
"  " let g:pymode_rope_extract_method_bind = '<C-c>rm'
"  " let g:pymode_rope_extract_variable_bind = '<C-c>rl'
"  " let g:pymode_rope_use_function_bind = '<C-c>ru'
"
"  " "よくわからない機能たち
"  " " let g:pymode_rope_move_bind = '<C-c>rv'
"  " " let g:pymode_rope_change_signature_bind = '<C-c>rs'
"  " let g:pymode_lint_sort = ['E', 'C', 'I']
"
"  let g:pymode_syntax_slow_sync = 0
"  let g:pymode_syntax_all = 1
"  let g:pymode_syntax_print_as_function = 0
"  let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
"  let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
"  " Highlight 'self' keyword
"  let g:pymode_syntax_highlight_self           = g:pymode_syntax_all
"  " Highlight indent's errors
"  let g:pymode_syntax_indent_errors            = g:pymode_syntax_all
"  " Highlight space's errors
"  let g:pymode_syntax_space_errors             = g:pymode_syntax_all
"  " Highlight string formatting
"  let g:pymode_syntax_string_formatting        = g:pymode_syntax_all
"  let g:pymode_syntax_string_format            = g:pymode_syntax_all
"  let g:pymode_syntax_string_templates         = g:pymode_syntax_all
"  let g:pymode_syntax_doctests                 = g:pymode_syntax_all
"  " Highlight builtin objects (True, False, ...)
"  let g:pymode_syntax_builtin_objs             = g:pymode_syntax_all
"  " Highlight builtin types (str, list, ...)
"  let g:pymode_syntax_builtin_types            = g:pymode_syntax_all
"  " Highlight exceptions (TypeError, ValueError, ...)
"  let g:pymode_syntax_highlight_exceptions     = g:pymode_syntax_all
"  " Highlight docstrings as pythonDocstring (otherwise as pythonString)
"  let g:pymode_syntax_docstrings               = g:pymode_syntax_all
"
"  "}}}
"  call dein#untap()
"endif
"" }}} "
"
"" davidhalter/jedi-vim {{{
"if dein#tap('jedi-vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy"    : 1,
"        \ "disabled"    : !has('python'),
"        \ "on_ft" : ['python', 'python3', 'djangohtml'],
"        \ "on_source" : ['python-mode'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    " If not setting this, set pythoncomplete to omnifunc, which is uncomfortable
"    augroup myjedivim
"      autocmd!
"      autocmd FileType python nnoremap <silent> <buffer> R :call jedi#rename()<cr>
"      autocmd FileType python nnoremap <silent> <buffer> <LocalLeader>n :call jedi#usages()<cr>
"      autocmd FileType python nnoremap <silent> <buffer> gf :call jedi#goto_assignments()<cr>
"      autocmd FileType python nnoremap <silent> <buffer> gd :call jedi#goto()<cr>
"      autocmd FileType python nnoremap <silent> <buffer> K :call jedi#show_documentation()<cr>
"      " autocmd FileType python setlocal omnifunc=jedi#completions
"    augroup END
"    call jedi#configure_call_signatures()
"  endfunction "}}}
"
"  " Setting {{{
"  " let g:jedi#completions_command = "<C-N>"
"  " 自動設定機能をoffにし手動で設定を行う
"  set noshowmode
"  let g:jedi#auto_initialization  = 0
"  let g:jedi#auto_vim_configuration = 0
"  let g:jedi#popup_on_dot = 0
"  let g:jedi#auto_close_doc = 0
"  let g:jedi#show_call_signatures = 2
"  let g:jedi#show_call_signatures_delay = -1
"
"  "quickrunと被るため大文字に変更
"  " let g:jedi#rename_command = 'R'
"  let g:jedi#goto_assignments_command = 'gf'
"  let g:jedi#goto_definitions_command = 'gd'
"  " let g:jedi#use_tabs_not_buffers = 1
"  " let g:jedi#completions_enabled = 1
"  "
"  " Configuration necocomplete, because of conflicts to one {{{
"  if !exists('g:neocomplete#sources#omni#functions')
"    let g:neocomplete#sources#omni#functions = {}
"  endif
"  let g:neocomplete#sources#omni#functions.python = 'jedi#completions'
"
"  call dein#untap()
"endif
"" }}} "
""}}}
"
"" lambdalisue/vim-pyenv {{{
"if dein#tap('vim-pyenv')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'disabled' : !has('python'),
"        \   'external_commands' : ['pyenv'],
"        \   'on_source' :  ['jedi-vim'],
"        \   'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    augroup vim-pyenv-custom-augroup
"      autocmd! 
"      autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
"      autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
"    augroup END
"  endfunction "}}}
"
"  " Setting {{{
"  let g:pyenv#auto_create_ctags = 0
"  let g:pyenv#auto_assign_ctags  = 1
"
"  function! s:jedi_auto_force_py_version() abort
"    let major_version = pyenv#python#get_internal_major_version()
"    call jedi#force_py_version(major_version)
"  endfunction
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
""}}}
"
"" Vim: {{{
"" syngan/vim-vimlint {{{
"if dein#tap('vim-vimlint')
"  " Config {{{
"  call dein#config({
"        \ 'lazy' : 1,
"        \ 'depends' : 'ynkdir/vim-vimlparser',
"        \   'on_ft' : 'vim',
"        \   'functions' : 'vimlint#vimlint',
"        \   'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
""}}}
"
"" WEB Programming: {{{
"" mattn/emmet-vim {{{
"if dein#tap('emmet-vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \ "on_ft" : ['html', 'css'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    let g:user_emmet_leader_key = '<C-Y>'
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" vim-scripts/css_color.vim {{{
"if dein#tap('css_color.vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   "on_ft" : ['html','css'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" hail2u/vim-css3-syntax {{{
"if dein#tap('vim-css3-syntax')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   "on_ft" : ['css'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" othree/html5.vim {{{
"if dein#tap('html5.vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   "on_ft" : ['html', 'svg', 'rdf'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" elzr/vim-json {{{
"if dein#tap('vim-json')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   "on_ft" : ['json'],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:vim_json_syntax_conceal = 2
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
""}}}
"
"" Java:
"
"" Android: {{{
"" hsanson/vim-android {{{
"if dein#tap('vim-android')
"  " Config {{{
"  call dein#config({
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:android_sdk_path = $ANDROID_SDK
"  " let g:gradle_path = /path/to/gradle
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
""}}}
"
""Writing: {{{
"
"" itchyny/dictionary.vim {{{
"if dein#tap('dictionary.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'disabled' : !has('mac'),
"        \   'depends' : [],
"        \   'on_i' : 0,
"        \   'on_unite' : ['help'],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  nnoremap <Leader>w :<C-u>Dictionary -cursor-word -no-duplicate<CR>
"  autocmd FileType dicitonary  nnoremap <buffer><Leader>w :<C-u>Dictionary -cursor-word -no-duplicate<CR>
"  autocmd FileType dicitonary  nnoremap <buffer><CR> <Plug>(dictionary_jump)
"  autocmd FileType dicitonary  nnoremap <buffer><BS> <Plug>(dictionary_jump_back)
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"" vim-latex/vim-latex {{{
"if dein#tap('vim-latex')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \   "on_ft": ["tex"],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    set grepprg=grep\ -nH\ $*
"    "キー配置の変更
"    ""<Ctrl + J>はパネルの移動と被るので番うのに変える
"    imap <C-n> <Plug>IMAP_JumpForward
"    nmap <C-n> <Plug>IMAP_JumpForward
"    vmap <C-n> <Plug>IMAP_DeleteAndJumpForward
"    " if !has('gui_running')
"    "     set <m-i>=i
"    "     set <m-b>=b
"    "     set <m-l>=l
"    "     set <m-c>=c
"    " endif
"    nnoremap j g<Down>
"    nnoremap k g<Up>
"    nnoremap gj j
"    nnoremap gk k
"  endfunction "}}}
"
"  " Setting {{{
"  let g:tex_flavor='latex'
"  let g:Imap_UsePlaceHolders = 1
"  let g:Imap_DeleteEmptyPlaceHolders = 1
"  let g:Imap_StickyPlaceHolders = 0
"  let g:Tex_DefaultTargetFormat = 'pdf'
"  let g:Tex_MultipleCompileFormats='pdf'
"  " let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"  " let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
"  let g:Tex_FormatDependency_ps = 'dvi,ps'
"  let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"  "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"  "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"  "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"  "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"  "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
"  let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"  let g:Tex_BibtexFlavor = 'upbibtex'
"  let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"  let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
"  " let g:Tex_UseEditorSettingInDVIViewer = 1
"  " let g:Tex_ViewRule_pdf = 'xdg-open'
"  " let g:Tex_ViewRule_pdf = 'evince_sync'
"  let g:Tex_ViewRule_pdf = 'evince'
"  "let g:Tex_ViewRule_pdf = 'okular --unique'
"  "let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"  "let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"  "let g:Tex_ViewRule_pdf = 'texworks'
"  "let g:Tex_ViewRule_pdf = 'mupdf'
"  "let g:Tex_ViewRule_pdf = 'firefox -new-window'
"  "let g:Tex_ViewRule_pdf = 'chromium --new-window'
"  let g:Tex_IgnoreLevel = 9
"  let g:Tex_IgnoredWarnings =
"        \"Underfull\n".
"        \"Overfull\n".
"        \"specifier changed to\n".
"        \"You have requested\n".
"        \"Missing number, treated as zero.\n".
"        \"There were undefined references\n".
"        \"Citation %.%# undefined\n".
"        \"LaTeX Font Warning: Font shape `%s' undefined\n".
"        \"LaTeX Font Warning: Some font shapes were not available, defaults substituted."
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" lervag/vimtex {{{
"if dein#tap('vimtex')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_ft': ['tex'],
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    nnoremap <buffer> <Space>la :call latex#motion#next_section(0,1,0)<CR>v:call latex#motion#next_section(0,0,1)<CR>:call <SID>previewTex()<CR>
"    vnoremap <buffer> <Space>la :call <SID>previewTex()<CR>
"    nnoremap <buffer> <Space>ls :call <SID>syncTexForward()<CR>
"  endfunction "}}}
"
"  " Setting {{{
"  " fold
"  let g:latex_fold_parts = [
"        \ "appendix",
"        \ "frontmatter",
"        \ "mainmatter",
"        \ "backmatter",
"        \ ]
"  let g:latex_fold_sections = [
"        \ "part",
"        \ "chapter",
"        \ "section",
"        \ "subsection",
"        \ "subsubsection",
"        \ ]
"  let g:latex_fold_enabled = 1
"  let g:latex_fold_automatic = 1
"  let g:latex_fold_envs = 1
"
"  " let g:vimtex_latexmk_options = '--pdfdvi'
"
"  if has('unix') && s:executable('okular')
"    let g:vimtex_view_general_viewer = 'okular'
"    let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
"    let g:vimtex_view_general_options_latexmk = '--unique'
"  elseif has('mac')
"    let g:vimtex_view_general_viewer
"          \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
"    let g:vimtex_view_general_options = '@line @pdf @tex'
"  endif
"
"
"  " 自動コンパイル
"  let g:latex_latexmk_continuous = 1
"  let g:latex_latexmk_background = 1
"  " コンパイル終了後のエラー通知オフ
"  let g:latex_latexmk_callback = 0
"
"  let g:latex_toc_split_pos = "topleft"
"  let g:latex_toc_width = 10
"
"  " SyncTex
"  function! s:syncTexForward()
"    call system('/Applications/Skim.app/Contents/SharedSupport/displayline -g '
"          \ . line(".") . " "
"          \ . g:latex#data[b:latex.id].out() . " "
"          \ . expand('%:p'))
"  endfunction"}}}
"
"  " Preview
"  function! s:previewTex() range "{{{
"    let l:tmp = @@
"    silent normal gvy
"    let l:selected = split(@@, "\n")
"    let @@ = l:tmp
"
"    let l:template1 = ["\\documentclass[a4paper]{jsarticle}",
"          \"\\usepackage[dvipdfmx]{graphicx}",
"          \"\\usepackage{amsmath,amssymb,bm}",
"          \"\\pagestyle{empty}",
"          \"\\begin{document}"]
"    let l:template2 = ["\\end{document}"]
"
"    let l:output_file = "preview.tex"
"    call writefile(extend(extend(l:template1, l:selected), template2), l:output_file)
"    silent call system("latexmk -pdfdvi preview &")
"  endfunction"}}}
"
"  " for neocomplete
"  if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"  endif
"  let g:neocomplete#sources#omni#input_patterns.tex = '\\ref{\s*[0-9A-Za-z_:]*'
"  "\citeも自動補完するなら
"  let g:neocomplete#sources#omni#input_patterns.tex = '\\cite{\s*[0-9A-Za-z_:]*\|\\ref{\s*[0-9A-Za-z_:]*'
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" rcmdnk/vim-markdown {{{
"if dein#tap('vim-markdown')
"  " Config {{{
"  call dein#config( {
"        \  'lazy' : 1,
"        \  'on_ft': ['markdown'],
"        \  'on_unite' : [
"        \    'help',
"        \  ],
"        \  'depends' : ['godlygeek/tabular', 'joker1007/vim-markdown-quote-syntax']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:vim_markdown_math=0
"  let g:vim_markdown_frontmatter = 0
"  let g:vim_markdown_no_default_key_mappings = 0
"  let g:vim_markdown_better_folding=0
"
"  let g:vim_markdown_initial_foldlevel=2
"  let g:vim_markdown_folding_disabled=1
"  "}}}
"
"
"  call dein#untap()
"endif
"" }}} "
"
"" TKNGUE/hateblo.vim {{{
"if dein#tap('hateblo.vim')
"  " Config {{{
"  call dein#config({
"        \ 'lazy'  : 1,
"        \ 'on_cmd' : ['HatebloCreate', 'HatebloList', 'HatebloCreateDraft'],
"        \ 'depends'  : ['mattn/webapi-vim', 'Shoug/unite.vim'],
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:hateblo_config_path = '$HOME/.hateblo/.hateblo.vim'
"  let g:hateblo_dir = '$HOME/.hateblo/blog'
"  "}}}
"  call dein#untap()
"endif
"" }}} "
"
"" TKNGUE/vim-reveal {{{
"if dein#tap('vim-reveal')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \   "on_ft" : ['markdown', 'md'],
"        \,
"        \})
"  "}}}
"  "
"
"  function! dein#tapped.hooks.on_source(bundle)
"    command! -buffer -nargs=0 RevealIt   call reveal#Md2Reveal()
"    command! -buffer -nargs=0 RevealOpen call reveal#open(reveal#preview_file_path())
"    command! -buffer -nargs=0 RevealEdit execute 'edit '.reveal#preview_file_path()
"  endfunction "}}}
"
"  " Setting {{{
"  let g:reveal_root_path = '~/.projects/reveal.js'
"  let g:revel_default_config = {
"        \ 'fname'  : 'reveal',
"        \ 'key1'  : 'reveal'
"        \ }
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" suan/vim-instant-markdown {{{
"if dein#tap('vim-instant-markdown')
"  " Config {{{
"  call dein#config({
"        \ 'lazy' : 1,
"        \ 'on_ft' : 'markdown',
"        \ 'on_unite' : [
"        \   'help',
"        \ ],
"        \ "build"       : {
"        \   "unix"      : "npm -g install instant-markdown-d",
"        \   "mac"       : "npm -g install instant-markdown-d",
"        \}})
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"
"  " vim-instant-markdown will update the display in realtime
"  let g:instant_markdown_slow = 1
"
"  " you want to manually control this behavior
"  let g:instant_markdown_autostart = 0
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" kannokanno/previm {{{
"if dein#tap('previm')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \   "on_ft" : ['markdown'],
"        \   "depends" : ['open-browser.vim'],
"        \ ,
"        \ "build"       : {
"        \   "cygwin"    : "pip install --user docutils",
"        \   "mac"       : "pip install --user docutils",
"        \   "unix"      : "pip install --user docutils"
"        \}})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
""
"" Rykka/InstantRst {{{
"if dein#tap('InstantRst')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   "on_ft": ["rst"],
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    " let g:instant_rst_browser = 'xdg-open'
"    " let g:instant_rst_localhost_only = 0
"    " let g:instant_rst_bind_scroll  = 1
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:instant_rst_localhost_only  = 1
"  "}}}
"
"  call dein#untap()
"endif "}}}
""
"" Rykka/riv.vim {{{
"if dein#tap('riv.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'depends' : [],
"        \   'on_ft' : ['rst'],
"        \   'on_cmd' : [],
"        \   'on_unite' : ['help'],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}}"
""}}}
"
"
"" clones/vim-zsh {{{
"if dein#tap('vim-zsh')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"" }}}
"
"" Unite Settings: {{{
"" Shougo/unite.vim {{{
"if dein#tap('unite.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_cmd' : [
"        \       {
"        \         'name' : 'Unite',
"        \         'complete' : 'customlist,unite#complete_source'
"        \       },
"        \       'UniteWithCursorWord',
"        \       'UniteWithInput'
"        \     ]
"        \ })
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    call unite#custom#profile('default', 'context', {
"          \   'start_insert': 1,
"          \   'direction': 'dynamictop',
"          \   'prompt': '» ',
"          \ })
"    nnoremap [unite]    <Nop>
"    nmap    <Leader>f  [unite]
"    nnoremap  [unite]s  :<C-u>Unite source<CR>
"    nnoremap  [unite]f  :<C-u>Unite -buffer-name=files -no-split
"          \ bookmark buffer file file_mru file_rec:~/Downloads
"          \ file/new directory/new <CR>
"    if has('nvim')
"      nnoremap <silent> [unite]F  :<C-u>UniteWithCurrentDir -buffer-name=files
"            \ file_rec/neovim
"            \ file/new directory/new <CR>
"    else
"      nnoremap <silent> [unite]F  :<C-u>UniteWithCurrentDir -buffer-name=files
"            \ file_rec/neovim
"            \ file/new directory/new <CR>
"    endif
"    nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
"          \ -buffer-name=files -prompt=%\  buffer bookmark file<CR>
"    nnoremap <silent> [unite]r  :<C-u>Unite
"          \ -buffer-name=register register<CR>
"    nnoremap <silent> [unite]o  :<C-u>Unite outline tag
"          \ -buffer-name=outline <CR>
"    nnoremap <silent> [unite]n  :<C-u>Unite
"          \ -buffer-name=bundles
"          \ neobundle/search <CR>
"    nnoremap <silent> [unite]s  :<C-u>Unite
"          \ -buffer-name=snippets
"          \ neosnippet <CR>
"    nnoremap <silent> [unite]ma :<C-u>Unite output:map output:map!
"          \ -buffer-name=mapping -hide-source-names<CR>
"    nnoremap <silent> [unite]me :<C-u>Unite output:message
"          \ -buffer-name=messages <CR>
"    " nnoremap <silent> [unite]b  :<C-u>Unite<Space>bookmark<CR>
"    nnoremap <silent> [unite]a  :<C-u>UniteBookmarkAdd<CR>
"
"    nnoremap <silent> [unite]l :<C-u>Unite  -buffer-name=search-lines line<CR>
"    nnoremap <qsilent> [unite]gf :<C-u>Unite -buffer-name=search-buffers grep:$buffers<CR>
"    nnoremap <silent> [unite]gj :<C-u>Unite -buffer-name=search-junks grep:$HOME/Dropbox/junks:-iR<CR>
"    nnoremap <silent> [unite]gg :<C-u>Unite -buffer-name=search-cd grep:./:-iR<CR>
"    nnoremap <silent> [unite]gc :<C-u>Unite -buffer-name=search-current-word grep:$buffers:<C-R><C-W><CR>
"    nnoremap <silent> [unite]R  :<C-u>Unite -buffer-name=resume resume<CR>
"    nnoremap <silent> [unite]h  :<C-u>Unite -buffer-name=help help<CR>
"    nnoremap <silent> [unite]z :<C-u>Unite -silent fold -vertical -winwidth=40 -no-start-insert<CR>
"    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord -buffer-name=help help<CR>
"    nnoremap <silent> [\ :UniteNext<CR>
"    nnoremap <silent> ]\ :UnitePrevious<CR>
"    nnoremap <silent> ]\ :UniteFirst<CR>
"    nnoremap <silent> [\ :UniteLast<CR>
"
"  endfunction "}}}
"
"  " Setting {{{
"
"  " Start insert.
"  let g:unite_source_history_yank_save_clipboard = 0
"  let g:unite_redraw_hold_candidates = 50000
"  let g:unite_source_file_rec_max_cache_files = 50000
"
"  " Like ctrlp.vim settings.
"  "call unite#custom#profile('default', 'context', {
"  "\   'start_insert': 1,
"  "\   'winheight': 10,
"  "\   'direction': 'botright',
"  "\ })
"
"
"  autocmd FileType unite call s:unite_my_settings()
"
"  function! s:unite_my_settings()
"    " Overwrite settings.
"    imap <buffer> jj      <Plug>(unite_insert_leave)
"    imap <buffer> kk      <Plug>(unite_insert_leave)
"    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
"
"    imap <buffer><expr> j unite#smart_map('j', '')
"    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
"    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
"    imap <buffer> '     <Plug>(unite_quick_match_default_action)
"    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
"    imap <buffer><expr> x
"          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)
"    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
"    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
"    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
"    " nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
"    imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
"    nnoremap <silent><buffer><expr> l
"          \ unite#smart_map('l', unite#do_action('default'))
"
"    let unite = unite#get_current_unite()
"    if unite.profile_name ==# 'search'
"      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
"    else
"      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
"    endif
"
"    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
"    nnoremap <buffer><expr>S      unite#mappings#set_current_sorters(
"          \ empty(unite#mappings#get_current_sorters()) ?
"          \ ['sorter_reverse'] : [])
"    nnoremap <buffer><expr>M    unite#mappings#set_current_matchers(
"          \ empty(unite#mappings#get_current_matchers()) ?
"          \ ['matcher_migemo'] : [])
"    nnoremap <buffer><expr>R    unite#mappings#set_current_matchers(
"          \ empty(unite#mappings#get_current_matchers()) ?
"          \ ['matcher_regexp'] : [])
"
"    " Runs "split" action by <C-s>.
"    imap <silent><buffer><expr> <C-s>     unite#do_action('split')
"
"
"    setl nofoldenable
"  endfunction "}}}
"
"  " mappingが競合するためデフォルトマッピング無効
"  " let g:unite_no_default_keymappings = 1
"  " nnoremap <silent> <Plug>(unite_exit)
"
"  " unite grep に ag(The Silver Searcher) を使う
"  if s:executable('ag')
"    let g:unite_source_grep_command = 'ag'
"    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"    let g:unite_source_grep_recursive_opt = ''
"    let g:unite_source_rec_async_command =split('ag --follow --nocolor --nogroup --hidden -g ""')
"  endif
"  "}}}
"  "
"  call dein#untap()
"endif
"" }}} "
"
"" Shougo/vimfiler.vim {{{
"if dein#tap('vimfiler.vim')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \   "on_cmd": [
"        \       { 'name' : 'VimFiler',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       { 'name' : 'VimFilerTab',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       { 'name' : 'VimFilerBufferDir',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       { 'name' : 'VimFilerExplorer',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       { 'name' : 'Edit',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       { 'name' : 'Write',
"        \         'complete' : 'customlist,vimfiler#complete' },
"        \       'Read', 'Source'
"        \       ],
"        \ 'on_map' : '<Plug>',
"        \ "explorer": 1,
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    call vimfiler#set_execute_file('txt', 'notepad')
"    call vimfiler#set_execute_file('c', ['gvim', 'notepad'])
"    call vimfiler#custom#profile('default', 'auto-cd', 'lcd')
"    call vimfiler#custom#profile('default', 'context', {
"          \ 'safe' : 0,
"          \ })
"  endfunction "}}}
"
"  " vimfiler specific key mappings {{{
"  function! s:vimfiler_settings()
"    " ^^ to go up
"    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
"    " use R to refresh
"    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
"    " overwrite C-l
"    nmap <buffer> <C-l> <C-w>l
"    nmap <buffer> <C-j> <C-w>j
"    nmap <buffer> p <Plug>(vimfiler_quick_look)
"  endfunction " }}}
"
"  function! VimFilerExplorerWithLCD() abort
"    execute "VimFilerExplorer ". expand('%:p:h')
"  endfunction
"
"  " Setting {{{
"  nnoremap <silent><Leader>e :call VimFilerExplorerWithLCD()<CR>
"  nnoremap <silent><Leader>E :VimFiler<CR>
"
"  augroup vimfile_options
"    " this one is which you're most likely to use?
"    autocmd FileType vimfiler call <SID>vimfiler_settings()
"    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
"  augroup END
"
"  let g:loaded_netrwPlugin = 1
"  let g:vimfiler_ignore_pattern = '\(\.git\|\.DS_Store\|.py[co]\|\%^\..\+\)\%$'
"  let g:vimfiler_tree_leaf_icon = ' '
"  let g:vimfiler_tree_opened_icon = '▾'
"  let g:vimfiler_tree_closed_icon = '▸'
"  let g:vimfiler_file_icon = ' '
"  let g:vimfiler_marked_file_icon = '*'
"  let g:vimfiler_enable_auto_cd = 1
"  let g:vimfiler_as_default_explorer = 1
"  let g:unite_kind_openable_lcd_command='lcd'
"  let g:vimfiler_as_default_explorer = 1
"  let g:vimfiler_split_rule="botright"
"  "}}}
"
"  call dein#untap()
"endif
""}}}
"
"" Shougo/unite-outline {{{
"if dein#tap('unite-outline')
"  " Config {{{
"  "}}}
"
"  " Setting {{{
"  nnoremap <silent> <Leader>o :<C-u>botright Unite -vertical -no-quit -winwidth=40 -direction=botright outline<CR>
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tsukkee/unite-tag {{{
"if dein#tap('unite-tag')
"  " Config {{{
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    autocmd BufEnter *
"          \   if empty(&buftype)
"    " \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
"          \|  endif
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"
"" Shougo/neomru.vim {{{
"if dein#tap('neomru.vim')
"  " Config {{{
"  call dein#config( {
"        \ "depends": ["Shougo/unite.vim"],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:neomru#do_validate = 1
"
"  let g:neomru#file_mru_ignore_pattern =
"        \'\~$\|\.\%(o\|exe\|dll\|bak\|zwc\|pyc\|sw[po]\)$'.
"        \'\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
"        \'\|^\%(\\\\\|/mnt/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'.
"        \'\|\%(^\%(fugitive\)://\)'
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tsukkee/unite-help {{{
"if dein#tap('unite-help')
"  " Config {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" Shougo/neossh.vim {{{
"if dein#tap('neossh.vim')
"  " Config {{{
"  call dein#config( {
"        \ "depends": ['Shougo/unite.vim']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" mattn/unite-advent_calendar {{{
"if dein#tap('unite-advent_calendar')
"  " Config {{{
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:calendar_frame = 'default'
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" }}}
"
"" Utilities Settings: {{{
"
"" Shougo/vimshell {{{
"if dein#tap('vimshell')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   'on_cmd' : ['VimShell']
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
"    call vimshell#set_execute_file('html,xhtml', 'gexe firefox')
"
"    autocmd FileType int-* call s:interactive_settings()
"
"    autocmd FileType vimshell
"          \ call vimshell#altercmd#define('g', 'git')
"          \| call vimshell#altercmd#define('i', 'iexe')
"          \| call vimshell#altercmd#define('l', 'll')
"          \| call vimshell#altercmd#define('ll', 'ls -l')
"          \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')
"  endfunction "}}}
"
"  " Setting {{{
"  nnoremap <silent> <Leader>vs :VimShell<CR>
"  nnoremap <silent> <Leader>vsc :VimShellCreate<CR>
"  nnoremap <silent> <Leader>vp :VimShellPop<CR>
"
"  let g:vimshell_interactive_update_time = 10
"
"  " vimshell setting
"  let g:vimshell_interactive_update_time = 10
"  " vimshell map
"  "let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"  let g:vimshell_right_prompt = 'fnamemodify(getcwd(), ":p:~")'
"
"  if has('win32') || has('win64')
"    " Display user name on Windows.
"    let g:vimshell_prompt = $USERNAME."% "
"  else
"    " Display user name on Linux.
"    let g:vimshell_prompt = $USER."% ". $HOST
"  endif
"
"  " Initialize execute file list.
"  let g:vimshell_execute_file_list = {}
"  let g:vimshell_execute_file_list['rb'] = 'ruby'
"  let g:vimshell_execute_file_list['pl'] = 'perl'
"  let g:vimshell_execute_file_list['py'] = 'python'
"  function! MyChpwd(args, context)
"    call vimshell#execute('ls')
"  endfunction
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" thinca/vim-template {{{
"if dein#tap('vim-template')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  augroup vim-template
"    autocmd!
"    autocmd User plugin-template-loaded
"          \ silent! %s/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge
"          \ | silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
"          \ | silent! %s/<+MONTH+>/\=eval(submatch(1))/ge
"          \ | silent! %s/<+FILENAME+>/\=expand('%:'))/ge
"          \ | if search('<+CURSOR+>') |  execute 'normal zv"_da>'| endif
"  augroup END
"
"  " Setting {{{
"  let g:template_basedir = '~/.vim'
"
"  command! -nargs=0 -complete=filetype Temp call s:open_template()
"  nmap <Space>/ :<C-u>call <SID>open_template()<CR>
"  function! s:open_template()
"    let l:template_name = template#search(expand('%:p'))
"    if l:template_name == ''
"      let l:template_name = g:template_basedir. '/template/template.'. &ft
"    endif
"    let l:filename = input('Template("template" are replaced with wild card): ', l:template_name)
"    if l:filename != ''
"      let l:template_dir= escape(fnamemodify(l:filename, ":p:h"), ' ()'))
"      if !isdirectory(l:template_dir)
"        call mkdir(l:template_dir, 'p')
"      endif
"      execute 'edit ' . l:filename
"    endif
"  endfunction
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" vim-scripts/Align {{{
"if dein#tap('Align')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
""
"" osyo-manga/vim-over {{{
"if dein#tap('vim-over')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:over_enable_cmd_windw = 1
"  " over.vimの起動
"  nnoremap <silent> <Leader>m :OverCommandLine<CR>
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" deton/jasegment.vim {{{
"if dein#tap('jasegment.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" kana/vim-smartchr {{{
"if dein#tap('vim-smartchr')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   "on_ft": ["tex"],
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" xolox/vim-session {{{
"if dein#tap('vim-session')
"  " Config {{{
"  call dein#config( {
"        \ 'depends' : 'xolox/vim-misc',
"        \ })
"  "}}}
"
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
"    if isdirectory(s:local_session_directory)
"      " session保存ディレクトリをそのディレクトリの設定
"      let g:session_directory = s:local_session_directory
"      " vimを辞める時に自動保存
"      let g:session_autosave = 'yes'
"      " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
"      let g:session_autoload = 'yes'
"      " 1分間に1回自動保存
"      let g:session_autosave_periodic = 1
"    else
"      let g:session_autosave = 'no'
"      let g:session_autoload = 'no'
"    endif
"    unlet s:local_session_directory
"
"  endfunction "}}}
"
"  " Setting {{{
"  " 現在のディレクトリ直下の .vimsessions/ を取得
"  command! MkDirSession call s:mk_dirsession()
"  function! s:mk_dirsession()
"    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
"    call mkdir(s:local_session_directory)
"    let g:session_directory = s:local_session_directory
"    unlet s:local_session_directory
"  endfunction
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" lambdalisue/vim-gista {{{
"if dein#tap('vim-gista')
"  " Config {{{
"  call dein#config({
"        \ "lazy": 1,
"        \ 'depends': [
"        \	'Shougo/unite.vim',
"        \	'tyru/open-browser.vim',
"        \],
"        \    'on_cmd': ['Gista'],
"        \    'mappings': '<Plug>(gista-',
"        \    'on_unite': 'gista',
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  " let g:gista#directory =
"  " let g:gista#token_directory =
"  " let g:gista#gist_entries_cache_directory =
"  " let g:gista#gist_default_filename =
"  " let g:gista#list_opener =
"  " let g:gista#gist_openers =
"  " let g:gista#gist_openers_in_action =
"  " let g:gista#close_list_after_open =
"  " let g:gista#auto_connect_after_post =
"  " let g:gista#update_on_write =
"  " let g:gista#enable_default_keymaps =
"  " let g:gista#post_private =
"  " let g:gista#interactive_description =
"  " let g:gista#interactive_visibility =
"  " let g:gista#include_invisible_buffer_in_multiple =
"  " let g:gista#unite_smart_open_threshold =
"  " let g:gista#gistid_yank_format =
"  " let g:gista#gistid_yank_format_with_file =
"  " let g:gista#gistid_yank_format_in_post =
"  " let g:gista#gistid_yank_format_in_save =
"  " let g:gista#default_yank_method =
"  " let g:gista#auto_yank_after_post =
"  " let g:gista#auto_yank_after_save =
"  " let g:gista#disable_python_client =
"  " let g:gista#suppress_acwrite_info_message =
"  " let g:gista#suppress_not_owner_acwrite_info_message =
"  " let g:gista#warn_in_partial_save =
"  " let g:gista#get_with_authentication
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" KazuakiM/vim-regexper {{{
"if dein#tap('vim-regexper')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" itchyny/calendar.vim {{{
"if dein#tap('calendar.vim')
"  " Config {{{
"  call dein#config( {
"        \       'on_cmd' : 'Calendar'
"        \})
"  "}}}
"
"  let g:calendar_google_calendar = 1
"  let g:calendar_google_task = 1
"  function! dein#tapped.hooks.on_source(bundle)
"    augroup MyCalandarVim
"      autocmd!
"      autocmd FileType calendar :IndentGuidesDisable
"    augroup END
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" cohama/agit.vim {{{
"if dein#tap('agit.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" moznion/github-commit-comment.vim {{{
"if dein#tap('github-commit-comment.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \   'depends' : ['jceb/vim-hier', 'dannyob/quickfixstatus']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"
"  call dein#untap()
"endif
"" }}} "
""
""jaxbot/github-issues.vim  " Github issue lookup in Vim {{{
"if dein#tap('github-issues.vim')
"  " Config {{{
"  call dein#config({
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" tejr/vim-tmux {{{
"if dein#tap('vim-tmux')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" benmills/vimux {{{
"if dein#tap('vimux')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" christoomey/vim-tmux-navigator {{{
"if dein#tap('vim-tmux-navigator')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
"    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
"    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
"    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"    nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
"  endfunction "}}}
"
"  " Setting {{{
"  let g:tmux_navigator_save_on_switch = 0
"  let g:tmux_navigator_no_mappings = 0
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tpope/vim-fugitive   {{{
"if dein#tap('vim-fugitive')
"  " Config {{{
"  call dein#config({'augroup' : 'fugitive'})
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    silent call ConfigOnGitRepository()
"    augroup FUGITIVE
"      autocmd!
"      autocmd BufReadPost * silent call ConfigOnGitRepository()
"    augroup END
"  endfunction "}}}
"
"  function! FugitiveMyMake()
"    let l:error = system(&l:makeprg)
"    redraw!
"    " echohl Special
"    for error in split(l:error, '\n')
"      echomsg error
"    endfor
"    " echohl None
"    execute 'call fugitive#cwindow()'
"  endfunction "}}}
"
"  command! Make call FugitiveMyMake()
"
"  function! ConfigOnGitRepository()
"    if !exists('b:git_dir')
"      return
"    endif
"    let git_path = escape(fnamemodify(b:git_dir, ':p:h:h'), ' ()')
"    execute 'lcd '. git_path
"    nnoremap <buffer> [git] <Nop>
"    nmap <buffer> <Leader>g [git]
"    nnoremap <buffer> [git]w :<C-u>Gwrite<CR>
"    nnoremap <buffer> [git]c :<C-u>Gcommit<CR>
"    nnoremap <buffer> [git]C :<C-u>Gcommit --amend<CR>
"    nnoremap <buffer> [git]s :<C-u>Gstatus<CR>
"    nnoremap <buffer> [git]d :<C-u>Gdiff<CR>
"    nnoremap <buffer> [git]p :<C-u>Gpush<CR>
"    " nnoremap <buffer> [git]P :<C-u>call MyGitPull()<CR>
"    if &l:path !~# git_path
"      let &l:path .= ','.git_path
"    endif
"  endfunction "}}}
"
"  call dein#untap()
"endif
"" }}} "Git操作用 プラグイン
"
"" majutsushi/tagbar {{{
"if dein#tap('tagbar')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  nnoremap <silent> ,q :TagbarToggle<CR>
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" haya14busa/incsearch.vim {{{
"if dein#tap('incsearch.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  " noremap <silent><expr> / incsearch#go({'command':'/','keymap':{'/':{'key':'\/','noremap':1}, ';' : {'key':'/;/', 'noremap':1}} })
"  " noremap <silent><expr> ? incsearch#go({'command':'?','keymap':{'?':{'key':'\?','noremap':1}} })
"  " map /  <Plug>(incsearch-forward)
"  " map ?  <Plug>(incsearch-backward)
"  map g/ <Plug>(incsearch-stay)
"
"  let g:incsearch#separate_highlight = 1
"  let g:incsearch#auto_nohlsearch = 1
"  map n  <Plug>(incsearch-nohl-n)zz
"  map N  <Plug>(incsearch-nohl-N)zz
"  map *  <Plug>(incsearch-nohl-*)zz
"  map #  <Plug>(incsearch-nohl-#)zz
"  map g* <Plug>(incsearch-nohl-g*)zz
"  map g# <Plug>(incsearch-nohl-g#)zz
"
"  call dein#untap()
"endif " }}} "
""}}}
"
"" Lokaltog/vim-easymotion {{{
"if dein#tap('vim-easymotion')
"  " Config {{{
"  " =======================================
"  " Boost your productivity with EasyMotion
"  " =======================================
"  " Disable default mappings
"  " If you are true vimmer, you should explicitly map keys by yourself.
"  " Do not rely on default bidings.
"  let g:EasyMotion_do_mapping = 0
"
"  " Or map prefix key at least(Default: <Leader><Leader>)
"  " map <Leader> <Plug>(easymotion-prefix)
"
"  " =======================================
"  " Find Motions
"  " =======================================
"  " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
"  " `s{char}{char}{target}`
"  " map <Leader>f <Plug>(easymotion-fl)
"  " map <Leader>F <Plug>(easymotion-Fl)
"  " map <Leader>t <Plug>(easymotion-tl)
"  " map <Leader>T <Plug>(easymotion-Tl)
"  nmap gs <Plug>(easymotion-s2)
"  xmap gs <Plug>(easymotion-s2)
"  omap z <Plug>(easymotion-s2)
"  " Of course, you can map to any key you want such as `<Space>`
"  " map <Space>(easymotion-s2)
"
"  " Turn on case sensitive feature
"  let g:EasyMotion_smartcase = 1
"
"  " =======================================
"  " Line Motions
"  " =======================================
"  " `JK` Motions: Extend line motions
"  " map gj <Plug>(easymotion-j)
"  " map gk <Plug>(easymotion-k)
"  " keep cursor column with `JK` motions
"  let g:EasyMotion_startofline = 0
"
"  " =======================================
"  " General Configuration
"  " =======================================
"  let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
"  " Show target key with upper case to improve readability
"  let g:EasyMotion_use_upper = 1
"  " Jump to first match with enter & space
"  let g:EasyMotion_enter_jump_first = 1
"  let g:EasyMotion_space_jump_first = 1
"
"  " =======================================
"  " Search Motions
"  " =======================================
"  " Extend search motions with vital-over command line interface
"  " Incremental highlight of all the matches
"  " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
"  " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
"  " :h easymotion-command-line
"  nmap g/ <Plug>(easymotion-sn)
"  xmap g/ <Plug>(easymotion-sn)
"  omap g/ <Plug>(easymotion-tn)
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" vim-jp/vimdoc-ja'         {{{
"if dein#tap('vimdoc-ja')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} " ヘルプの日本語化
"
"" mattn/learn-vimscript'    {{{
"if dein#tap('learn-vimscript')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} " help for vim script
"
"" vim-jp/vital.vim {{{
"if dein#tap('vital.vim')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" uguu-org/vim-matrix-screensaver {{{
"if dein#tap('vim-matrix-screensaver')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" tsukkee/lingr-vim {{{
"if dein#tap('lingr-vim')
"  " Config {{{
"  call dein#config( {
"        \ "lazy": 1,
"        \   'on_cmd' : ['Lingr']
"        \})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:lingr_vim_user = 'mnct.tkn3011@gmail.com'
"  let g:lingr_vim_sidebar_width = 25
"  let g:lingr_vim_rooms_buffer_height = 10
"  let g:lingr_vim_say_buffer_height = 3
"  let g:lingr_vim_remain_height_to_auto_scroll = 5
"  let g:lingr_vim_time_format     = '%c'
"  let g:lingr_vim_command_to_open_url = 'firefox %s'
"
"  function! s:notify(title, message)
"    if has('unix') && s:executable('notify-send')
"      let notify_cmd = 'notify-send %s %s'
"    elseif has('windows')
"      let notify_cmd = 'notify-send %s %s'
"    elseif has('mac')
"      let notify_cmd = 'growlnotify -t %s -m %s'
"    else
"    endif
"    execute printf('silent !'. notify_cmd, shellescape(a:title, 1), shellescape(a:message, 1))
"  endfunction
"
"  augroup lingr-vim
"    autocmd!
"    " autocmd User WinEnter
"    autocmd User plugin-lingr-message
"          \   let s:temp = lingr#get_last_message()
"          \|  if !empty(s:temp)
"            \|      call s:notify(s:temp.nickname, s:temp.text)
"            \|  endif
"            \|  unlet s:temp
"
"    autocmd User plugin-lingr-presence
"          \   let s:temp = lingr#get_last_member()
"          \|  if !empty(s:temp)
"            \|      call s:notify(s:temp.name, (s:temp.presence ? 'online' : 'offline'))
"            \|  endif
"            \|  unlet s:temp
"  augroup END
"
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" TKNGUE/atcoder_helper {{{
"if dein#tap('atcoder_helper')
"  " Config {{{
"  call dein#config({})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:online_jadge_path = '/home/takeno/.local/src/OnlineJudgeHelper/oj.py'
"  let g:atcoder_config = '/home/takeno/.local/src/OnlineJudgeHelper/setting.json'
"  let g:atcoder_dir = '$HOME/Documents/codes/atcoder'
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" TKNGUE/sum-it.vim {{{
"if dein#tap('sum-it.vim')
"  " Config {{{
"  call dein#config( {})
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"  " Setting {{{
"  "}}}
"  call dein#untap()
"endif
""}}}
"
"" fuenor/im_control.vim {{{
"if dein#tap('im_control.vim')
"  " Config {{{
"  call dein#config({
"        \ 'external-commands' : 'python',
"        \ })
"  "}}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    " 「日本語入力固定モード」切替キー
"    " inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
"    " PythonによるIBus制御指定
"    "バッファ毎に日本語入力固定モードの状態を制御。
"    " let g:IM_CtrlBufLocalMode = 1
"  endfunction "}}}
"
"  " Setting {{{
"  function! IMCtrl(cmd)
"    let cmd = a:cmd
"    if cmd == 'On'
"      let res = system('ibus engine "mozc-jp"')
"    elseif cmd == 'Off'
"      let res = system('ibus engine "xkb:en::en"')
"    endif
"    return ''
"  endfunction
"  "}}}
"
"  call dein#untap()
"endif
"" }}} "
"
"" matchit.zip {{{
"if dein#tap('matchit.zip')
"  " Config {{{
"  call dein#config({'lazy' : 0})
"  "}}}
"
"  " Setting {{{
"  "}}}
"  call dein#untap()
"endif
""}}}
"
"" thinca/vim-ref {{{
"if dein#tap('vim-ref')
"  " Config {{{
"  call dein#config({
"        \  'on_unite' : [
"        \    'help',
"        \  ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    augroup ref_vim
"      autocmd!
"      autocmd FileType ref-webdict call s:initialize_ref_viewer()
"      autocmd FileType ref-man call s:initialize_ref_viewer()
"    augroup END
"    function! s:initialize_ref_viewer()
"      nmap <buffer> b <Plug>(ref-back)
"      nmap <buffer> f <Plug>(ref-forward)
"      nnoremap <buffer> q <C-w>c
"      setlocal nonumber
"      " ... and more settings ...
"    endfunction "}}}
"    function! g:ref_source_webdict_sites.alc.filter(output)
"      let l:output = substitute(a:output, "^.\\+_\\+", "", "")
"      return "ALC dictoinary\n------------\n". join(split(l:output,'\n')[10:], "\n")
"    endfunction "}}}
"    function! g:ref_source_webdict_sites.weblio.filter(output)
"      let l:output = substitute(a:output, '.\{-}から変更可能\n', '', "")
"      let l:output = substitute(l:output, '\n\n', '\n', "g")
"      let l:output = substitute(l:output, '\(\w\{1,2\}\)\n', '\1 ', "g")
"      " let l:output = substitute(l:output, '\s*\a\zs\n\+', '', "g")
"      return "Weblio dictoinary\n------------\n".join(split(l:output,'\n'), "\n")
"    endfunction "}}}
"  endfunction "}}}
"
"  " Setting {{{
"  "Ref webdictでalcを使う設定
"  let g:ref_no_default_key_mappings = 0
"  " let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
"  let g:ref_source_webdict_use_cache = 1
"  let g:ref_source_webdict_sites = {
"        \ 'alc' : {
"        \   'url' : 'http://eow.alc.co.jp/%s/UTF-8/'
"        \   },
"        \ 'weblio' : {
"        \   'url' : 'http://ejje.weblio.jp/content/%s/'
"        \   }
"        \ }
"  let g:ref_source_webdict_sites['default'] = "weblio"
"  let g:ref_detect_filetype=  {
"        \ '_': ['man','webdict'],
"        \ 'gitcommit': 'webdict',
"        \ 'markdown': ['webdict', 'ALC'],
"        \ 'c': 'man',
"        \ 'clojure': 'clojure',
"        \ 'perl': 'perldoc',
"        \ 'php': 'phpmanual',
"        \ 'ruby': 'refe',
"        \ 'vim': '',
"        \ 'cpp': 'man',
"        \ 'tex': 'webdict',
"        \ 'erlang': 'erlang',
"        \ 'python': 'pydoc',
"        \}
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" tyru/open-browser.vim {{{
"if dein#tap('open-browser.vim')
"  " Config {{{
"  call dein#config({
"        \     'on_cmd': ['OpenURL'],
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:openbrowser_search_engines = {
"        \       'alc': 'http://eow.alc.co.jp/{query}/UTF-8/',
"        \       'askubuntu': 'http://askubuntu.com/search?q={query}',
"        \       'baidu': 'http://www.baidu.com/s?wd={query}&rsv_bp=0&rsv_spt=3&inputT=2478',
"        \       'blekko': 'http://blekko.com/ws/+{query}',
"        \       'cpan': 'http://search.cpan.org/search?query={query}',
"        \       'devdocs': 'http://devdocs.io/#q={query}',
"        \       'duckduckgo': 'http://duckduckgo.com/?q={query}',
"        \       'github': 'http://github.com/search?q={query}',
"        \       'google': 'http://google.com/search?q={query}',
"        \       'google-scholar': 'https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0,5&q={query}',
"        \       'google-code': 'http://code.google.com/intl/en/query/#q={query}',
"        \       'php': 'http://php.net/{query}',
"        \       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
"        \       'twitter-search': 'http://twitter.com/search/{query}',
"        \       'twitter-user': 'http://twitter.com/{query}',
"        \       'verycd': 'http://www.verycd.com/search/entries/{query}',
"        \       'vim': 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
"        \       'wikipedia': 'http://en.wikipedia.org/wiki/{query}',
"        \       'wikipedia-ja': 'http://ja.wikipedia.org/wiki/{query}',
"        \       'yahoo': 'http://search.yahoo.com/search?p={query}',
"        \}
"  nmap gb <Plug>(openbrowser-smart-search)
"  vmap gb <Plug>(openbrowser-smart-search)
"  nmap gw :OpenBrowserSearch -wikipedia-ja <C-R><C-W><CR>
"  nmap gs :OpenBrowserSearch -wikipedia-ja <C-R><C-W><CR>
"  vmap gs :OpenBrowserSearch -goole-scholar <C-R><C-W><CR>
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" lilydjwg/colorizer {{{
"if dein#tap('colorizer')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_cmd' : ['ColorHighlight'],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:colorizer_startup = 0
"  let g:colorizer_nomap = 1
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" thinca/vim-singleton {{{
"if dein#tap('vim-singleton')
"
"  " Config {{{
"  call dein#config({
"        \   'disable' : !has('clientserver'),
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    call singleton#enable()
"  endfunction "}}}
"
"  call dein#untap()
"endif
"
"" }}}
"
"" osyo-mang/vim-precious {{{
"if dein#tap('vim-precious')
"  " Config {{{
"  call dein#config({
"        \   'augroup' : 'vim-precious',
"        \   'depends' : ['Shougo/context_filetype.vim'],
"        \     'on_ft' : ['markdown', 'rst', 'help'],
"        \     'on_cmd' : ['Precious'],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    augroup precious_autocmd
"      autocmd!
"      autocmd FileType markdown,rst,help
"            \ nmap <buffer><leader>r
"            \ <Plug>(precious-quickrun-op)icx
"      " autocmd User PreciousFileType :echo precious#context_filetype()
"    augroup END
"  endfunction "}}}
"
"  " Setting {{{
"  let g:precious_enable_switchers = {
"        \   "*" : { "setfiletype" : 0 },
"        \}
"  "
"  " let g:precious_enable_switchers = {
"  "             \	"*" : {
"  "             \		"setfiletype" : 0
"  "             \	},
"  "             \}
"
"  " " コンテキストが切り替わった場合、syntax を設定
"  " augroup test
"  "     autocmd!
"  "     autocmd User PreciousFileType let &l:syntax = precious#context_filetype()
"  " augroup END
"  " <
"
"  let g:precious_enable_switch_CursorMoved = {
"        \   "*" : 0
"        \}
"
"  let g:precious_enable_switch_CursorMoved_i = {
"        \   "*" : 0
"        \}
"
"  "}}}
"  call dein#untap()
"endif
"" }}}
"
"" mbbill/undotree {{{
"if dein#tap('undotree')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_cmd' : ['UndotreeToggle'],
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    let g:undotree_WindowLayout=4
"    let g:undotree_SplitWidth=40
"  endfunction "}}}
"
"  " Setting {{{
"  nnoremap U :UndotreeToggle<CR>
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" Shougo/context_filetype.vim {{{
"if dein#tap('context_filetype.vim')
"  " Config {{{
"  call dein#config({
"        \   'lazy' : 1,
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  " Setting {{{
"  let g:context_filetype#filetypes = {
"        \ 'markdown': [
"        \   {
"        \     'start' : '^---$',
"        \     'end' : '^...$',
"        \     'filetype' : 'yaml',
"        \   },
"        \   {
"        \    'start' : '^\s*```\s*\(\h\w*\)',
"        \    'end' : '^\s*```$', 'filetype' : '\1',
"        \   },
"        \ ],
"        \}
"
"  let g:context_filetype#search_offset = 30
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" rhysd/github-complete.vim {{{
"if dein#tap('github-complete.vim')
"  " Config {{{
"  call dein#config({
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"    augroup config-github-complete
"      autocmd!
"      autocmd FileType gitcommit setl omnifunc=github_complete#complete
"    augroup END
"
"  endfunction "}}}
"
"  " Setting {{{
"  " let g:github_complete_enable_emoji_completion = 0
"  " " let g:github_complete_enable_neocomplete = 1
"  " let g:github_complete_emoji_japanese_workaround = 0
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" beloglazov/vim-online-thesaurus {{{
"if dein#tap('vim-online-thesaurus')
"  " Config {{{
"  call dein#config({
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  " let g:online_thesaurus_map_keys=0
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
"" kana/vim-submode {{{
"if dein#tap('vim-submode')
"  " Config {{{
"  call dein#config({
"        \     'on_unite' : [
"        \       'help',
"        \     ],
"        \ })
"  " }}}
"
"  function! dein#tapped.hooks.on_source(bundle)
"    function! s:SIDP()
"      return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SIDP$') . '_'
"    endfunction
"    function! s:movetab(nr)
"      execute 'tabmove' g:V.modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
"    endfunction
"
"    let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
"    call submode#enter_with('movetab', 'n', '', '<Space>gt', printf(s:movetab, 1))
"    call submode#enter_with('movetab', 'n', '', '<Space>gT', printf(s:movetab, -1))
"    call submode#map('movetab', 'n', '', 't', printf(s:movetab, 1))
"    call submode#map('movetab', 'n', '', 'T', printf(s:movetab, -1))
"    unlet s:movetab
"
"    call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
"    call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
"    call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
"    call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
"    call submode#map('winsize', 'n', '', '>', '<C-w>>')
"    call submode#map('winsize', 'n', '', '<', '<C-w><')
"    call submode#map('winsize', 'n', '', '+', '<C-w>-')
"    call submode#map('winsize', 'n', '', '-', '<C-w>+')
"  endfunction "}}}
"
"  function! dein#tapped.hooks.on_post_source(bundle)
"  endfunction "}}}
"
"  " Setting {{{
"  let g:submode_keep_leaving_key = 1
"  "}}}
"
"  call dein#untap()
"endif
"" }}}
"
" PLUGIN_SETTING_ENDPOINT
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}
filetype plugin indent on

"}}}

" Local settings ================ {{{
let s:local_vimrc = expand('~/.local.vimrc')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif
" }}}

" Finally ======================={{{

" Colorscheme: {{{
" Check color
" :so $VIMRUNTIME/syntax/colortest.vim
" Check syntax
" :so $VIMRUNTIME/syntax/hitest.vim
"
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
endif

"}}}

" Installation check.
if !has('vim_starting')
  " call dein#call_hook('on_source')
  " call dein#call_hook('on_post_source')
endif
"}}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker number nornu
