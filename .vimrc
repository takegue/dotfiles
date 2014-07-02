augroup MyAutoCmd
    autocmd!
augroup END

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


runtime! ~/.vim/conf.d/*.vim

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
