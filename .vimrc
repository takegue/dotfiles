"--------------------------------------------------
" .vimrc 設定ファイルの大元
"--------------------------------------------------
"Plugin Files: conf.d/*.vim 
"Use 'gf' to move to each configuration
"  "conf.d/basic.vim"
"  "conf.d/map.vim" 
"  "conf.d/misc.vim"
"  "conf.d/neobundle.vim"
"  | "conf.d/bundle/bundle-colorscheme.vim"  #colorschemeのbunlde
"  | "conf.d/bundle/bundle-design.vim"       #vimの見た目のbundle
"  | "conf.d/bundle/bundle-editor.vim"
"  | "conf.d/bundle/bundle-operator.vim"
"  | "conf.d/bundle/bundle-programming.vim"
"  | "conf.d/bundle/bundle-textobj.vim"
"  | "conf.d/bundle/bundle-unite.vim"
"  | "conf.d/bundle/bundle-util.vim"
"  | "conf.d/bundle/bundle-misc.vim"
runtime! conf.d/*.vim

"壁紙設定
colorscheme molokai
"透過を有効にするために黒背景にする
highlight Normal ctermbg=none

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない

filetype plugin indent on
