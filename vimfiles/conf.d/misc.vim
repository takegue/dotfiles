"--------------------------------------------------
" misc.vim
"--------------------------------------------------
" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" TODOコマンド
command! Todo call s:Todo() " Todoコマンド
" 一時ファイルコマンド

" Open junk file."{{{
command! -nargs=? -complete=filetype Tmp call s:open_junk_file('<args>')
command! -nargs=? -complete=filetype Temp call s:open_junk_file('<args>')
command! -nargs=0 -complete=filetype Memo call s:open_junk_file('memo')
" command! Memo call s:Memo() " Memoコマンド
function! s:open_junk_file(type)
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

command! -bang -nargs=* PluginTest call PluginTest(<bang>0, <q-args>)
function! PluginTest(is_gui, extraCommand)
    let cmd = a:is_gui ? 'gvim' : 'vim'
    let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * ' . a:extraCommand . '"'
    if !exists('b:git_dir')
        additional_path = fnamemodify(b:git_dir, ':p:h:h') 
    else
        additional_path = getcwd()
    endif
    execute '!' . cmd . ' -u ~/.vimrc.min -i NONE -N --cmd "set rtp+=' . additional_path . '"' . extraCommand
endfunction
"}}}
"
augroup edit_memo
    autocmd!
    autocmd BufNewFile,BufRead *.todo 
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
        lcd %:p:h
    else
        execute 'lcd' . a:directory
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
"==================================================
" autocmd Configuration
"==================================================
augroup MyAutoCmd
    autocmd!
    autocmd VimEnter * call s:ChangeCurrentDir('', '')
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
    autocmd BufRead */conf.d/*.vim setlocal path+=$HOME/.vim/bundle 
    " autocmd BufReadPost * call s:SwitchToActualFile()
augroup END

command! FollowSymlink call s:SwitchToActualFile()
function! s:SwitchToActualFile()
    let l:fname = resolve(expand('%:p'))
    let l:pos = getpos('.')
    let l:bufname = bufname('%')
    enew
    exec 'bw '. l:bufname
    exec "e" . fname
    call setpos('.', pos)
endfunction "}}}


function! s:RestoreCursorPostion()
    if line("'\"") <= line("$")
        normal! g`"
    endif
    try
        normal! zO
    catch /E490/
    endtry
endfunction

" Jump to the previous position when file opend
augroup vimrc_restore_cursor_position
    autocmd!
    autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END

augroup vimrc_change_cursorline_color
    autocmd!
    " インサートモードに入った時にカーソル行の色をブルーグリーンにする
    " autocmd InsertEnter * highlight CursorLine ctermbg=23 guibg=yellow 
    " autocmd InsertEnter * highlight CursorColumn ctermbg=24 guibg=#005f87
    " " インサートモードを抜けた時にカーソル行の色を黒に近いダークグレーにする
    " autocmd InsertLeave * highlight CursorLine ctermbg=236 guibg=#303030 
    " autocmd InsertLeave * highlight CursorColumn ctermbg=236 guibg=#303030
augroup END

augroup edit_vimrc
    autocmd!
    autocmd BufReadPost .vimrc setlocal path+=$HOME/.vim 
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    autocmd BufWritePost */conf.d/*.vim nested source %
augroup END
