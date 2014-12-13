"--------------------------------------------------
" misc.vim
"--------------------------------------------------
" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" TODOコマンド
command! Todo call s:Todo() " Todoコマンド
command! Memo call s:Memo() " Memoコマンド
" 一時ファイルコマンド

" Open junk file."{{{
command! -nargs=0 -complete=filetype Tmp call s:open_junk_file()
command! -nargs=0 -complete=filetype Temp call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_tmp'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
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

augroup MyAutoCmd
    autocmd!
    autocmd VimEnter * call s:ChangeCurrentDir('', '')
    autocmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
    " make, grep などのコマンド後に自動的にQuickFixを開く
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    " QuickFixおよびHelpでは q でバッファを閉じる
    autocmd FileType help,qf nnoremap <buffer> q <C-w>c
    autocmd FileType help,qf nnoremap <buffer> q <C-w>c
    autocmd CmdwinEnter * nnoremap <buffer>q  <C-w>c

    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

    autocmd WinLeave * set nocursorline norelativenumber 
    autocmd WinEnter * if &number | set cursorline relativenumber | endif
augroup END

