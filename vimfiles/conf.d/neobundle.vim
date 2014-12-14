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
    call neobundle#begin(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる
    NeoBundleFetch 'Shougo/neobundle.vim'
    " Use neobundle standard recipes.
    NeoBundle 'Shougo/neobundle-vim-recipes'

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

    runtime! conf.d/bundle/*.vim


    call neobundle#end()

    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck 

    if !has('vim_starting')
        " Call on_source hook when reloading .vimrc.
        call neobundle#call_hook('on_source')
    endif
endif
