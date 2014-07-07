"--------------------------------------------------
" .vimrc 設定ファイルの大元
"--------------------------------------------------
"Plugin Files: conf.d/*.vim
"  "conf.d/basic.vim"
"  "conf.d/map.vim"
"  "conf.d/misc.vim"
"  "conf.d/neobundle.vim"
"  "conf.d/bundle/"
"  | "conf.d/bundle/bundle-colorscheme.vim"  #colorschemeのbunlde
"  | "conf.d/bundle/bundle-design.vim"       #vimの見た目のbundle
"  | "conf.d/bundle/bundle-editor.vim"
"  | "conf.d/bundle/bundle-misc.vim"
"  | "conf.d/bundle/bundle-operator.vim"
"  | "conf.d/bundle/bundle-programming.vim"
"  | "conf.d/bundle/bundle-textobj.vim"
"  | "conf.d/bundle/bundle-unite.vim"
"  | "conf.d/bundle/bundle-util.vim"

augroup MyAutoCmd
    autocmd!
augroup END

" Load .gvimrc after .vimrc edited at GVim.
" Set augroup.
if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufReadPost  $MYVIMRC setlocal path+=$HOME/.vim
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    autocmd MyAutoCmd BufReadPost  $MYVIMRC  setlocal path+=$HOME/.vim
    autocmd MyAutoCmd BufWritePost $MYVIMRC  nested   source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC nested   source $MYVIMRC
    " .vimrcの再読込時にも色が変化するようにする
    " autocmd MyAutoCmd BufWritePost $MYVIMRC 4source $MYVIMRC | if has('gui_running') | source $MYGVIMRC 
endif

if has('gui_running')
    nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
    nnoremap <silent> <Space>.  :<C-u>edit $MYVIMRC<CR> 
endif
runtime! conf.d/*.vim

"壁紙設定
colorscheme molokai
" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
