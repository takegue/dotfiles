"release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

"####表示設定#####
set title 							"編集中のファイル名を表示
set showmatch 					"括弧入力時の対応する括弧を表示
syntax on 							"コードの色分け
set tabstop=4 					"インデントをスペース4つ分に設定
set shiftwidth=4				"オートインデントの幅
set smartindent 				"オートインデント
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる


" 前時代的スクリーンベルを無効化
set t_vb=4
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"####　編集関係 #####
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed 
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile


"素早くjj と押すことでESCとみなす
inoremap jj <Esc>
nnoremap ; :
nnoremap : ;

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

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
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

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

"##### Plug-in #######
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
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
		NeoBundle "Shougo/vimproc", {
					\ "build": {
					\   "windows"   : "make -f make_mingw32.mak",
					\   "cygwin"    : "make -f make_cygwin.mak",
					\   "mac"       : "make -f make_mac.mak",
					\   "unix"      : "make -f make_unix.mak",
					\ }}

 		" カラースキーム一覧表示に Unite.vim を使う
		NeoBundle 'Shougo/unite.vim'
		NeoBundle 'ujihisa/unite-colorscheme'
 
		NeoBundleLazy "Shougo/vimfiler", {
				\ "depends": ["Shougo/unite.vim"],          
				\ "autoload": {
				\   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
				\   "mappings": ['<Plug>(vimfiler_switch)'],
				\   "explorer": 1,
				\ }} 
		nnoremap <Leader>e :VimFilerExplorer<CR>
		" close vimfiler automatically when there are only vimfiler open
		autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
		let s:hooks = neobundle#get_hooks("vimfiler")
		function! s:hooks.on_source(bundle)
			let g:vimfiler_as_default_explorer = 1
			let g:vimfiler_enable_auto_cd = 1
			" 2013-08-14 追記
			let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"
			" vimfiler specific key mappings
			autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
			function! s:vimfiler_settings()
				" ^^ to go up
				nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
				" use R to refresh
				nmap <buffer> R <Plug>(vimfiler_redraw_screen)
				" overwrite C-l
				nmap <buffer> <C-l> <C-w>l
			endfunction
		endfunction

		"エディタ関係の便利ツール
		NeoBundle 'tpope/vim-surround'
		NeoBundle 'vim-scripts/Align'
		NeoBundle 'vim-scripts/YankRing.vim'
		NeoBundle 'tpope/vim-fugitive'

		NeoBundleLazy "vim-scripts/TaskList.vim", {
		      \ "autoload": {
		      \   "mappings": ['<Plug>TaskList'],
		      \}}
		nmap <Leader>T <plug>TaskList

		"プログラミング関係の便利ツール
		NeoBundleLazy "davidhalter/jedi-vim", {
					\'rev':'3934359',
					\ "autoload": {
					\   "filetypes": ["python", "python3", "djangohtml"],
					\ },
					\ "build": {
					\   "mac": "pip install jedi",
					\   "unix": "pip install jedi",
					\ }}
		let s:hooks = neobundle#get_hooks("jedi-vim")
		function! s:hooks.on_source(bundle)
			" jediにvimの設定を任せると'completeopt+=preview'するので
			" 自動設定機能をOFFにし手動で設定を行う
			let g:jedi#auto_vim_configuration = 0

			"補完の最初の項目が選択された状態だと使いにくいためオフにする
			let g:jedi#popup_on_dot = 1
			let g:jedi#popup_select_first = 0
			"quickrunと被るため大文字に変更
			let g:jedi#rename_command = '<Leader>R'
			" gundoと被るため大文字に変更 (2013-06-2410:00 追記）
			let g:jedi#goto_assignments_command = '<Leader>G'
		endfunction

		NeoBundleLazy "jcf/vim-latex", {
					\ "autoload": {
					\   "filetypes": ["tex"],
					\ }}
		let s:hooks = neobundle#get_hooks("vim-latex")
		function! s:hooks.on_source(bundle)
			set shellslash
			set grepprg=grep\ -nH\ $*
			let g:tex_flavor='platex'
			let g:Imap_UsePlaceHolders = 1
			let g:Imap_DeleteEmptyPlaceHolders = 1
			let g:Imap_StickyPlaceHolders = 0
			let g:Tex_DefaultTargetFormat = 'pdf'
			let g:Tex_FormatDependency_ps = 'dvi,ps'
			let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot -kanji=utf8 -no-guess-input-enc -synctex=0 -interaction=nonstopmode -file-line-error-style $*' 
			let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
			let g:Tex_BibtexFlavor = 'pbibtex -kanji=utf-8'
			let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
			let g:Tex_ViewRule_pdf = 'texworks'

			"キー配置の変更
			""<Ctrl + J>はパネルの移動と被るので番うのに変える
			imap <C-n> <Plug>IMAP_JumpForward
			nmap <C-n> <Plug>IMAP_JumpForward
			vmap <C-n> <Plug>IMAP_DeleteAndJumpForward

		endfunction
		"Solarized カラースキーム
		NeoBundle 'altercation/vim-colors-solarized'
		NeoBundle 'croaker/mustang-vim'
		NeoBundle 'jeffreyiacono/vim-colors-wombat'
		NeoBundle 'nanotech/jellybeans.vim'
		NeoBundle 'vim-scripts/Lucius'
		NeoBundle 'vim-scripts/Zenburn'
		NeoBundle 'mrkn/mrkn256.vim'
		NeoBundle 'jpo/vim-railscasts-theme'
		NeoBundle 'therubymug/vim-pyte'
		NeoBundle 'tomasr/molokai'

		" インストールされていないプラグインのチェックおよびダウンロード
		NeoBundleCheck

		colorscheme molokai
	endif

	" ファイルタイププラグインおよびインデントを有効化
	" これはNeoBundleによる処理が終了したあとに呼ばなければならない
	filetype plugin indent on


