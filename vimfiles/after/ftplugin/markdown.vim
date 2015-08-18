augroup markdown_augrope
    autocmd!
    autocmd BufWritePre <buffer> %s/^\s\+$//ge
augroup END

nnoremap <buffer><silent><Leader>= :<C-u>call append('.', repeat('=', max([40, strdisplaywidth(getline('.'))])))<CR>
nnoremap <buffer><silent><Leader>- :<C-u>call append('.', repeat('=', max([40, strdisplaywidth(getline('.'))])))<CR>

iab <buffer> tl - [ ]

if has('gui_running')
    inoremap <buffer><silent> <CR> <Space><Space><CR>
    inoremap <buffer><silent> <C-CR>  <CR><CR>
elseif &term == 'xterm-256color'
    " inoremap <buffer><silent> <CR> <Space><Space><CR>
    " inoremap <buffer><silent>    <CR><CR>
endif

