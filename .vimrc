augroup MyAutoCmd
    autocmd!
augroup END

set nocompatible        "vi互換を消す．VIMの時代

"--------------------------------------------------
" 表示設定
"--------------------------------------------------
set encoding=utf8
scriptencoding utf-8
set helplang=ja,en
set title               "編集中のファイル名を表示

set showmatch           "括弧入力時の対応する括弧を表示
syntax on               "コードの色分け
set list                " 不可視文字の可視化
set number              " 行番号の表示
set relativenumber      " 相対行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる
set cursorline          " 編集中の行のハイライト 
au MyAutoCmd WinLeave * set nocursorline norelativenumber 
au MyAutoCmd WinEnter * if &number | set cursorline relativenumber | endif


set smartindent         "オートインデント
" set autoindent 
set cindent
set tabstop=8
set shiftwidth=4        "オートインデントの幅
set softtabstop=4       "インデントをスペース4つ分に設定
set expandtab           "タブ→スペースの変換
set wildmenu wildmode=longest,full "コマンドラインの補間表示

set list                " 不可視文字の可視化
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:♩ "⏎ "
            \u ;

" 前時代的スクリーンベルを無
set t_vb=
set novisualbell

"--------------------------------------------------
" 検索設定
"--------------------------------------------------
set smartcase           "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan            "検索時に最後まで行ったら最初に戻る
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"--------------------------------------------------
" 編集設定
"--------------------------------------------------
set shiftround              " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase               " 補完時に大文字小文字を区別しない
set virtualedit=all         " カーソルを文字が存在しない部分でも動けるようにする
set hidden                  " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen       " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch               " 対応する括弧などをハイライト表示する
set matchtime=3             " 対応括弧のハイライト表示を3秒にする
set nrformats=hex
set history=10000           " ヒストリ機能を10000件まで有効にする

" TODOコマンド
command! Todo call s:Todo()
au MyAutoCmd BufNewFile,BufRead *.todo set nonumber norelativenumber filetype=markdown

function! s:Todo()
    let l:path  =  '~/.todo'   
    if filereadable(expand('~/Dropbox/.todo'))
        let l:path = expand('~/Dropbox/.todo')
    endif
    if bufwinnr(l:path) < 0
        execute 'silent bo 60vs +set\ nonumber ' . l:path 
    endif
    unlet! l:path
endfunction

" MEMOコマンド
command! Memo call s:Memo()
au MyAutoCmd BufNewFile,BufRead *.memo set nonumber norelativenumber filetype=markdown
function! s:Memo()
    let l:path  =  '~/.memo'   
    if filereadable(expand('~/Dropbox/.memo'))
        let l:path = expand('~/Dropbox/.memo')
    endif
    if bufwinnr(l:path) < 0
        execute 'silent bo 60vs +set\ nonumber ' . l:path 
    endif
    unlet! l:path
endfunction

" 一時ファイル
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

" Load .gvimrc after .vimrc edited at GVim.
" Set augroup.  
if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC nested source $MYVIMRC
    " .vimrcの再読込時にも色が変化するようにする
    " autocmd MyAutoCmd BufWritePost $MYVIMRC 4source $MYVIMRC | if has('gui_running') | source $MYGVIMRC 
endif

if has('gui_running')
    nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
    nnoremap <silent> <Space>.  :<C-u>edit $MYVIMRC<CR>
endif


" ftplugin設定編集反映用
let g:ftpPath = $HOME . "/.vim/after/ftplugin/" 
nnoremap <silent>  <Space>, :<C-u>call <SID>openFTPluginFile()<CR>
function! s:openFTPluginFile()
    let l:ftpFileName = g:ftpPath . &filetype . ".vim"
    execute 'botright vsplit ' . l:ftpFileName
endfunction 

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus') 
    set clipboard& clipboard+=unnamedplus,unnamed 
else 
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

"--------------------------------------------------
" Key Mapping
"--------------------------------------------------

"<Leader>を,に変更
let mapleader=','

"素早くjj と押すことでESCとみなす
" inoremap jj <Esc>
nnoremap ; :
nnoremap : ;

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc>    :noh<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz    

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
" nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent><C-F> :<C-U>setl lazyredraw<CR><C-D><C-D>:setl nolazyredraw<CR>
nnoremap <silent><C-B> :<C-U>setl lazyredraw<CR><C-U><C-U>:setl nolazyredraw<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

"--------------------------------------------------
" Toggle
"--------------------------------------------------
nnoremap [toggle] <Nop>
nmap <Leader>t [toggle]
nnoremap <silent> [toggle]s : setl spell!<CR>          : setl spell?<CR>
nnoremap <silent> [toggle]l : setl list!<CR>           : setl list?<CR>
nnoremap <silent> [toggle]t : setl expandtab!<CR>      : setl expandtab?<CR>
nnoremap <silent> [toggle]w : setl wrap!<CR>           : setl wrap?<CR>
nnoremap <silent> [toggle]c : setl cursorline!<CR>     : setl cursorline?<CR>
nnoremap <silent> [toggle]n : setl number!<CR>         : setl number?<CR>
nnoremap <silent> [toggle]r : setl relativenumber!<CR> : setl relativenumber?<CR>
nnoremap <silent> [toggle]p : set paste!<CR> 

"自動で括弧内に移動
inoremap {} {}<left>
inoremap [] []<left>
inoremap () ()<left>
inoremap <> <><left>
inoremap '' ''<left>
inoremap `` ``<left>
inoremap "" ""<left>

"自動で---, ===を変換"
iab ---- --------------------------------------------------<CR>
iab ==== ==================================================<CR>
iab ++++ ++++++++++++++++++++++++++++++++++++++++++++++++++<CR>
iab ____ __________________________________________________<CR>
iab //// //////////////////////////////////////////////////<CR>


" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c


" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif
    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif


"==================================================
" autocmd Configuration
"==================================================
" autocmd MyAutoCmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

"==================================================
" NeoBundle Plugin
"==================================================
let s:noplugin = 0
let s:bundle_root =  has('win32') || has('win64') ?
            \ expand('~/vimfiles/bundle') : expand('~/.vim/bundle') 
let s:neobundle_root = s:bundle_root . '/neobundle.vim'

if (!isdirectory(s:neobundle_root) || v:version < 702 )
    " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
    " 読み込まない
    let s:noplugin = 1
else

    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root 
    endif 
    call neobundle#rc(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる
    NeoBundleFetch 'Shougo/neobundle.vim'

    " 非同期通信を可能にする
    " 'build'が指定されているのでインストール時に自動的に
    " 指定されたコマンドが実行され vimproc がコンパイルされる
    NeoBundle 'Shougo/vimproc.vim', {
                \ "build": {
                \   "windows"   : "make -f make_mingw64.mak",
                \   "cygwin"    : "make -f make_cygwin.mak",
                \   "mac"       : "make -f make_mac.mak",
                \   "unix"      : "make -f make_unix.mak",
                \ }}

    "--------------------------------------------------
    " VimShell 
    "------------------------------------------------- 
    NeoBundleLazy 'Shougo/vimshell', {
                \ 'autoload' : {
                \   'commands' : ['VimShell']
                \ }}
    nnoremap <silent> <Leader>vs :VimShell<CR>
    nnoremap <silent> <Leader>vsc :VimShellCreate<CR>
    nnoremap <silent> <Leader>vp :VimShellPop<CR>
    let s:hooks = neobundle#get_hooks('vimshell')
    function! s:hooks.on_source(bundle)
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
        call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
        let g:vimshell_execute_file_list['rb'] = 'ruby'
        let g:vimshell_execute_file_list['pl'] = 'perl'
        let g:vimshell_execute_file_list['py'] = 'python'
        call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

        autocmd FileType vimshell
                    \ call vimshell#altercmd#define('g', 'git')
                    \| call vimshell#altercmd#define('i', 'iexe')
                    \| call vimshell#altercmd#define('l', 'll')
                    \| call vimshell#altercmd#define('ll', 'ls -l')
                    \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')

        function! MyChpwd(args, context)
            call vimshell#execute('ls')
        endfunction

        autocmd FileType int-* call s:interactive_settings()
        function! s:interactive_settings()
        endfunction

    endfunction


    "--------------------------------------------------
    " Vim-Operator
    "------------------------------------------------- 
    NeoBundle 'kana/vim-operator-user'
    NeoBundle 'tpope/vim-commentary'                        "コメント切り替えオペレータ
    NeoBundle 'tpope/vim-surround'                          "surround記号編集オペレータ
    "sort用オtpope/vim-operator-userペレータ
    NeoBundle 'emonkak/vim-operator-sort', {                
                \ 'depends' : ['tpope/vim-operator-user']   
                \}
    NeoBundle 'pekepeke/vim-operator-tabular', {
                \ 'depends' : ['pekepeke/vim-csvutil'] 
                \}
    NeoBundle 'tyru/operator-camelize.vim'                  "Camelizeまたはdecamelize(snake_case) オペレータ
    NeoBundle 'yomi322/vim-operator-suddendeath'            "突然の死ジェネレータ


    "--------------------------------------------------
    " Vim-TextObj
    "------------------------------------------------- 
    NeoBundle "kana/vim-textobj-user"
    NeoBundle 'kana/vim-textobj-function'                   "関数オブジェクト(C, Java, Vim)
    

    NeoBundle "kana/vim-textobj-entire"                     "全体選択オブジェクト   #ae, ai
    NeoBundle "kana/vim-textobj-datetime"                   "日付選択オブジェクト   #ada, add, adt
    NeoBundle "thinca/vim-textobj-comment"                  "コメントオブジェクト   #ac, ic×
    NeoBundle "mattn/vim-textobj-url"                       "URLオブジェクト        #au, iu
    NeoBundle "rbonvall/vim-textobj-latex"                  "LaTeXオブジェクト      #
    NeoBundleLazy 'bps/vim-textobj-python', {
                \ 'autoload' : {
                \   'filetypes' : ['python', 'pytest']
                \}}
    NeoBundle 'michaeljsmith/vim-indent-object'             "同Indentオブジェクト   #ai. ii, aI, iI

    "--------------------------------------------------
    " Unite-Source
    "------------------------------------------------- 
    NeoBundle 'Shougo/unite.vim'
    let s:hooks = neobundle#get_hooks('unite.vim')
    function! s:hooks.on_source(bundle)
        nnoremap [unite]    <Nop>
        nmap    <Leader>f  [unite]
        nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
        nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
        nnoremap <silent> [unite]m :<C-u>Unite<Space>file file_mru<CR>
        nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>   "bookmarkを追加可能に

        " mappingが競合するためデフォルトマッピング無効
        " let g:unite_no_default_keymappings = 1
        " nnoremap <silent> <Plug>(unite_exit)
    endfunction

    NeoBundle 'Shougo/unite-outline', {
                \ "depends": ["Shougo/unite.vim"],
                \ } 
    let s:hooks = neobundle#get_hooks("unite-outline")
    function! s:hooks.on_source(bundle) 
        nnoremap <silent> <Leader>o :<C-u>botright Unite -vertical -no-quit -winwidth=40 -direction=botright outline<CR> 

    endfunction

    NeoBundle 'ujihisa/unite-colorscheme'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'tsukkee/unite-help'
    " nnoremap <silent> :<C-u>Unite -start-insert help<CR>
    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

    NeoBundle 'Shougo/neossh.vim', {
                \ "depends": ['Shougo/unite.vim']
                \}

    " 'Advent Calendarまとめ'
    NeoBundle 'mattn/unite-advent_calendar', {
                \ "depends": ['tyru/open-browser.vim', 'mattn/webapi-vim'],
                \}

    NeoBundleLazy 'Shougo/vimfiler.vim', {
                \ "autoload": {
                \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
                \   "mappings": ['<Plug>(vimfiler_switch)'],
                \   "explorer": 1,
                \ }} 
    nnoremap <Leader>e :VimFilerExplorer<CR>
    nnoremap <Leader>E :VimFiler<CR>
    " close vimfiler automatically when there are only vimfiler open
    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    let s:hooks = neobundle#get_hooks("vimfiler.vim")
    function! s:hooks.on_source(bundle)
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_enable_auto_cd = 1
        " 2013-08-14 追記
        let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"
        " vimfiler specific key mappings
        autocmd MyAutoCmd FileType vimfiler call <SID>vimfiler_settings()
        function! s:vimfiler_settings()
            " ^^ to go up 
            nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
            " use R to refresh
            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
            " overwrite C-l
            nmap <buffer> <C-l> <C-w>l
        endfunction
    endfunction

    NeoBundle 'tacroe/unite-mark', {
                \ "depends": ["Shougo/unite.vim"]
                \ } 

    "--------------------------------------------------
    " Colorscheme
    "------------------------------------------------- 
    NeoBundle 'nanotech/jellybeans.vim'
    NeoBundle 'vim-scripts/Lucius'
    NeoBundle 'vim-scripts/Zenburn'
    NeoBundle 'mrkn/mrkn256.vim'
    NeoBundle 'jpo/vim-railscasts-theme' 
    NeoBundle 'tomasr/molokai'
    NeoBundle 'vim-scripts/Wombat'
    NeoBundle 'altercation/vim-colors-solarized'

    "--------------------------------------------------
    " Syntax
    "--------------------------------------------------
    NeoBundle 'plasticboy/vim-markdown'
    NeoBundle 'kannokanno/previm'
    NeoBundle 'tejr/vim-tmux'


    "---------------------------------------------------
    " Design
    "-------------------------------------------------- 
    NeoBundle 'nathanaelkane/vim-indent-guides' 
    autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
    autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238 
    let s:hooks = neobundle#get_hooks("vim-indent-guides")
    function! s:hooks.on_source(bundle)
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_start_level = 1
        let g:indent_guides_guide_size = 1 
        IndentGuidesEnable 
    endfunction 

    NeoBundle 'itchyny/lightline.vim'
    let s:hooks = neobundle#get_hooks('lightline.vim')
    function! s:hooks.on_source(bundle)
        let g:lightline = {
                    \ 'colorscheme': 'wombat',
                    \ 'mode_map': {'c': 'NORMAL'},
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
                    \ },
                    \ 'component_function': {
                    \   'modified': 'MyModified',
                    \   'readonly': 'MyReadonly',
                    \   'fugitive': 'MyFugitive',
                    \   'filename': 'MyFilename',
                    \   'fileformat': 'MyFileformat',
                    \   'filetype': 'MyFiletype',
                    \   'fileencoding': 'MyFileencoding',
                    \   'mode': 'MyMode'
                    \ }} 
        function! MyModified()
            return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction 
        function! MyReadonly()
            return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
        endfunction 
        function! MyFilename()
            return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                        \  &ft == 'unite' ? unite#get_status_string() :
                        \  &ft == 'vimshell' ? vimshell#get_status_string() :
                        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                        \ ('' != MyModified() ? ' ' . MyModified() : '')
        endfunction 
        function! MyFugitive()
            try
                if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
                    return fugitive#head()
                endif
            catch
            endtry
            return ''
        endfunction

        function! MyFileformat()
            return winwidth(0) > 70 ? &fileformat : ''
        endfunction

        function! MyFiletype()
            return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        endfunction

        function! MyFileencoding()
            return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! MyMode()
            return winwidth(0) > 60 ? lightline#mode() : ''
        endfunction  
    endfunction 

    " ヘルプの日本語化
    NeoBundle 'vim-jp/vimdoc-ja'

    "--------------------------------------------------
    " 文書作成プラグイン 
    "-------------------------------------------------- 
    NeoBundle 'vim-scripts/Align'
    "NeoBundle 'vim-scripts/YankRing.vim'
    NeoBundle 'tpope/vim-fugitive'          "Git操作用 プラグイン
    function! s:SwitchToActualFile()
        let fname = resolve(expand('%:p'))
        bwipeout #
        exec "e " . fname
    endfunction
    command! FollowSymlink call s:SwitchToActualFile()

    NeoBundle 'osyo-manga/vim-over'
    let s:hooks = neobundle#get_hooks("vim-over")
    function! s:hooks.on_source(bundle) 
        let g:over_enable_cmd_windw = 1
        " over.vimの起動  
        nnoremap <silent> <Leader>ss :OverCommandLine<CR> 
        " " カーソル下の単語をハイライト付きで置換
        " nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left> 
        " " コピーした文字列をハイライト付きで置換
        " nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left> 
    endfunction

    NeoBundle 'xolox/vim-session', {
                \ 'depends' : 'xolox/vim-misc',
                \ } 
    let s:hooks = neobundle#get_hooks("vim-session")
    function! s:hooks.on_source(bundle) 
        " 現在のディレクトリ直下の .vimsessions/ を取得 
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

        command! MkDirSession call s:mk_dirsession()
        function! s:mk_dirsession()    "session用のディレクトリ作成関数
            let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
            call mkdir(s:local_session_directory)
            let g:session_directory = s:local_session_directory
            unlet s:local_session_directory
        endfunction
    endfunction 

    "置換キーワードを定義する: >
    NeoBundle 'thinca/vim-template' 
    "置換キーワードを定義する: >
    let s:hooks = neobundle#get_hooks("vim-template")
    function! s:hooks.on_source(bundle) 
        autocmd User plugin-template-loaded call s:template_keywords()
        function! s:template_keywords()
            silent! %s/<+FILE NAME+>/\=expand('%:t')/g
            silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
            silent! %s/<+MONTH+>/\=strftime('%m')/g
            " And more...
        endfunction
        "<%= %> の中身をvimで評価して展開する: >
        autocmd User plugin-template-loaded
                    \ silent %s/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge
        autocmd User plugin-template-loaded
                    \ if search('<+CURSOR+>')
                    \ | execute 'normal! "_da>"'
                    \ | endif 
        nnoremap <Space>/  :<C-u>call <SID>template_open()<CR> 
        function! s:template_open()
            let l:path=template#search(expand('%:p')) 
            execute 'botright vsplit ' . l:path
        endfunction 
    endfunction 

    "WORD移動用文書区切り用
    NeoBundle "deton/jasegment.vim" 

    NeoBundleLazy 'kana/vim-smartchr', { 
                \ "autoload": {
                \   "filetypes": ["tex"],
                \ }} 

    "--------------------------------------------------
    " Programming
    "--------------------------------------------------
    NeoBundle 'thinca/vim-quickrun'
    nnoremap <silent> <Leader>r :QuickRun<CR>
    nnoremap <silent> <Leader>se :QuickRun sql<CR>
    let s:hooks = neobundle#get_hooks("vim-quickrun")
    function! s:hooks.on_source(bundle)
        let g:quickrun_config = {
                    \ "_": {
                    \   "runner"                    : "vimproc",
                    \   "runner/vimproc/updatetime" : "60",
                    \   "outputter/buffer/split"    : ":bo vsplit"
                    \,}}
        let g:quickrun_config.sql ={
                    \ 'command' : 'mysql',
                    \ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
                    \ 'exec'    : ['%c %o < %s' ] ,
                    \}
        let g:quickrun_config['php.unit'] = {
                    \ 'command': 'testrunner',
                    \ 'cmdopt': 'phpunit'
                    \} 
        " let g:quickrun_config['python.unit'] = {i
        "             \ 'command': 'nosetests',
        "             \ 'cmdopt': '-v -s'
        "             \}
        let g:quickrun_config['python.pytest'] = {
                    \ 'command': 'py.test',
                    \ 'cmdopt': '-v'
                    \}
        let g:quickrun_config.markdown  = {
                    \ 'type' : 'markdown/pandoc',
                    \ }
        let g:quickrun_config['ruby.rspec']  = {
                    \ 'command': 'rspec'
                    \ , 'cmdopt': '-f d'
                    \ }
        augroup QuickRunUnitTest
            autocmd!
            autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
            "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
            autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
            autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
            autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
        augroup END

    endfunction 
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
    "--------------------------------------------------
    " Programming - Python
    "--------------------------------------------------
    NeoBundleLazy 'alfredodeza/pytest.vim', {
                \ 'autoload'    : {
                \   'filetypes' : ['python', 'python3'],
                \ },
                \ 'build'       : {
                \   "cygwin"    : "pip install pytest",
                \   "mac"       : "pip install pytest",
                \   "unix"      : "pip install pytest"
                \ }}

    NeoBundleLazy 'davidhalter/jedi-vim', {
                \ "autoload"    : {
                \   "filetypes" : ["python", "python3", "djangohtml"],
                \ },
                \ "build"       : {
                \   "cygwin"    : "pip install jedi",
                \   "mac"       : "pip install jedi",
                \   "unix"      : "pip install jedi"
                \ }}

    let g:jedi#auto_vim_configuration = 0
    let s:hooks = neobundle#get_hooks("jedi-vim")
    function! s:hooks.on_source(bundle)
        " 自動設定機能をoffにし手動で設定を行う
        let g:jedi#auto_vim_configuration = 0

        let g:jedi#popup_on_dot = 1
        let g:jedi#popup_select_first = 1
        "quickrunと被るため大文字に変更
        let g:jedi#rename_command = '<Leader>R'
        let g:jedi#auto_close_doc = 0
        let g:jedi#use_tabs_not_buffers = 0
        let g:jedi#completions_enabled = 0

    endfunction

    NeoBundleLazy 'nvie/vim-flake8', { 
                \ "autoload"    : {
                \   "filetypes" : ["python", "python3", "djangohtml"],
                \ },
                \ "build"       : {
                \   "cygwin"    : "pip install flake8",
                \   "mac"       : "pip install flake8",
                \   "unix"      : "pip install flake8",
                \ }}

    let s:hooks = neobundle#get_hooks("nvie/vim-flake8")
    function! s:hooks.on_source(bundle)
    endfunction

    NeoBundleLazy 'tell-k/vim-autopep8', { 
                \ "autoload"    : {
                \   "filetypes" : ["python", "python3", "djangohtml"],
                \ },
                \ "build"       : {
                \   "cygwin"    : "pip install autopep8",
                \   "mac"       : "pip install autopep8",
                \   "unix"      : "sudo pip install autopep8",
                \ }}

    let s:hooks = neobundle#get_hooks("tell-k/vim-autopep8")
    function! s:hooks.on_source(bundle) 
    endfunction

    "--------------------------------------------------
    " Programming - LaTex
    "--------------------------------------------------
    NeoBundleLazy 'jcf/vim-latex', {
                \ "autoload": {
                \   "filetypes": ["tex"],
                \ }}
    let g:tex_flavor = 'platex'
    let s:hooks = neobundle#get_hooks("vim-latex")
    function! s:hooks.on_source(bundle)
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot -kanji=utf8 -no-guess-input-enc -synctex=0 -interaction=nonstopmode -file-line-error-style $*' 
        let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
        let g:Tex_BibtexFlavor = 'pbibtex -kanji=utf-8 $*'
        let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
        let g:Tex_ViewRule_pdf = 'texworks'

        "キー配置の変更
        ""<Ctrl + J>はパネルの移動と被るので番うのに変える
        imap <C-n> <Plug>IMAP_JumpForward
        nmap <C-n> <Plug>IMAP_JumpForward
        vmap <C-n> <Plug>IMAP_DeleteAndJumpForward 
    endfunction




    NeoBundle 'Shougo/neocomplcache.vim'
    let g:neocomplcache_enable_at_startup = 1 " Use neocomplcache.
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
        "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)! 
        let g:neocomplcache_enable_at_startup = 0       "Disable AutoComplPop.
        let g:neocomplcache_enable_smart_case = 1       " Use smartcase.
        let g:neocomplcache_min_syntax_length = 3       " Set minimum syntax keyword length.  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*' " Enable heavy features.
        " Use camel case completion.
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        let g:neocomplcache_enable_underbar_completion = 0
    
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        " inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <silent><Tab> <C-R>=pumvisible() ? "\<lt>C-n>": "\<lt>Tab>"<CR>


        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return neocomplcache#smart_close_popup() . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        " inoremap <TAB>  <C-R>=pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()


        " For cursor moving in insert mode(Not recommended)
        "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
        "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
        "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
        "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
        " Or set this.
        "let g:neocomplcache_enable_cursor_hold_i = 1
        " Or set this.
        "let g:neocomplcache_enable_insert_char_pre = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        let g:neocomplcache_enable_auto_select = 0
        "let g:neocomplcache_disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"


        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcompete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        if !exists('g:neocomplcache_force_omni_patterns')
            let g:neocomplcache_force_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.php =
                    \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
        let g:neocomplcache_omni_patterns.c =
                    \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
        let g:neocomplcache_omni_patterns.cpp =
                    \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplcache_omni_patterns.perl =
                    \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : ''
                    \ }
    endfunction
    " ステータスバー



    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'honza/vim-snippets'
    NeoBundle 'Shougo/neosnippet.vim' , {
                \  'depends' : "Shougo/neocomplcache.vim"
                \}
    let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

        " SuperTab like snippets behavior.
        imap <expr><TAB> pumvisible() ? "\<C-n>" 
                    \: neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)"
                    \: "\<TAB>"

        let g:neosnippet#snippets_directory = [ '~/.vim/bundle/vim-snippets/snippets','~/.vim/snippets']

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

    endfunction 
    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck 

endif
"壁紙設定
colorscheme molokai
" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
