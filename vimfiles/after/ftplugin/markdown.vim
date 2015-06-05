
augroup markdown_augrop
    autocmd!
    autocmd BufWritePre <buffer> %s/^\s\+$//ge
augroup END


if has('gui_running')
    inoremap <buffer><silent> <CR> <Space><Space><CR>
    inoremap <buffer><silent> <C-CR>  <CR><CR>
elseif &term == 'xterm-256color'
    " inoremap <buffer><silent> <CR> <Space><Space><CR>
    " inoremap <buffer><silent>    <CR><CR>
endif





