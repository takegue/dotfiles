set nocompatible        "vi互換を消す．VIMの時代

"--------------------------------------------------
" 表示設定
"--------------------------------------------------
set encoding=utf8

set helplang=ja,en
set spelllang+=cjk
set title               "編集中のファイル名を表示
set ambiwidth=double    "全角文字で幅が崩れないように調整する

syntax on               "コードの色分け 
set showmatch           "括弧入力時の対応する括弧を表示
set list                " 不可視文字の可視化
set number              " 行番号の表示
set relativenumber      " 相対行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる
set cursorline          " 編集中の行のハイライト 

set smartindent         "オートインデント
" set autoindent 
set cindent
set tabstop=8
set shiftwidth=4        "オートインデントの幅
set softtabstop=4       "インデントをスペース4つ分に設定
set expandtab           "タブ→スペースの変換
set wildmenu wildmode=longest,full "コマンドラインの補間表示

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:⏎ "

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

if has('unnamedplus') && !(has("win32") || has("win64"))
    set clipboard=unnamedplus,autoselectplus
else
    set clipboard=unnamed
endif


" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif
  
"==================================================
" autocmd Configuration
"==================================================
" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c
autocmd MyAutoCmd CmdwinEnter * nnoremap <buffer>q  <C-w>c

autocmd MyAutoCmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

autocmd MyAutoCmd WinLeave * set nocursorline norelativenumber 
autocmd MyAutoCmd WinEnter * if &number | set cursorline relativenumber | endif

