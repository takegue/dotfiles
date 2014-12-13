function! s:RestoreCursorPostion()
  if line("'\"") <= line("$")
    normal! g`"
  endif
endfunction
" Jump to the previous position when file opend
augroup vimrc_restore_cursor_position
  autocmd!
  autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END

augroup vimrc_change_cursorline_color
    autocmd!
    " インサートモードに入った時にカーソル行の色をブルーグリーンにする
    autocmd InsertEnter * highlight CursorLine ctermbg=24 guibg=#005f87 | highlight CursorColumn ctermbg=24 guibg=#005f87
    " インサートモードを抜けた時にカーソル行の色を黒に近いダークグレーにする
    autocmd InsertLeave * highlight CursorLine ctermbg=236 guibg=#303030 | highlight CursorColumn ctermbg=236 guibg=#303030
augroup END

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

