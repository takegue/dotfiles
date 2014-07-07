"--------------------------------------------------
" misc.vim
"--------------------------------------------------

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" TODOコマンド
command! Todo call s:Todo() " Todoコマンド
command! Memo call s:Memo() " Memoコマンド
" 一時ファイルコマンド
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
autocmd MyAutoCmd BufNewFile,BufRead *.todo set nonumber norelativenumber filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.memo set nonumber norelativenumber filetype=markdown


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

" after/ftpluginの作成 User設定のftp
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
