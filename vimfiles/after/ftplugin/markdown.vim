setl nowrap
setl norelativenumber nonumber

augroup markdown_augrope
    autocmd!
    autocmd BufWritePre <buffer> %s/^\s\+$//ge
augroup END

nnoremap <buffer><silent><Leader>= :<C-u>call append('.', repeat('=', max([40, strdisplaywidth(getline('.'))])))<CR>
nnoremap <buffer><silent><Leader>- :<C-u>call append('.', repeat('-', max([40, strdisplaywidth(getline('.'))])))<CR>

iab <buffer> tl - [ ]

if has('gui_running')
    inoremap <buffer><silent> <CR> <Space><Space><CR>
    inoremap <buffer><silent> <C-CR>  <CR><CR>
elseif &term == 'xterm-256color'
    " inoremap <buffer><silent> <CR> <Space><Space><CR>
    " inoremap <buffer><silent>    <CR><CR>
endif


" 入れ子のリストを折りたたむ
setlocal foldmethod=expr foldexpr=MkdCheckboxFold(v:lnum) foldtext=MkdCheckboxFoldText()
function! MkdCheckboxFold(lnum)
    let line = getline(a:lnum)
    let next = getline(a:lnum + 1)
    if MkdIsNoIndentCheckboxLine(line) && MkdHasIndentLine(next)
        return 1
    elseif (MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !MkdHasIndentLine(next)
        return '<1'
    endif
    return '='
endfunction
function! MkdIsNoIndentCheckboxLine(line)
    return a:line =~ '^- \[[ x]\] '
endfunction
function! MkdHasIndentLine(line)
    return a:line =~ '^[[:blank:]]\+'
endfunction
function! MkdCheckboxFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction

" 選択行のチェックボックスを切り替える
function! ToggleCheckbox()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
        " 完了時刻を挿入する
        let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '') . ' [' . strftime("%Y/%m/%d (%a) %H:%M") . ']'
        call setline('.', l:result)
    elseif l:line =~ '\-\s\[x\]'
        let l:result = substitute(substitute(l:line, '-\s\[x\]', '- [ ]', ''), '\s\[\d\{4}.\+]$', '', '')
        call setline('.', l:result)
    end
endfunction


" todoリストのon/offを切り替える
nnoremap <buffer><silent> <Leader><Leader> :<C-u>call ToggleCheckbox()<CR>
vnoremap <buffer><silent> <Leader><Leader> :<C-u>call ToggleCheckbox()<CR>

set shiftwidth=4
