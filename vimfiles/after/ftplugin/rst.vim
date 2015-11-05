set nowrap
set norelativenumber nonumber

nnoremap <buffer><silent><Leader>= :<C-u>call append('.', repeat('=', max([40, strdisplaywidth(getline('.'))])))<CR>
nnoremap <buffer><silent><Leader>- :<C-u>call append('.', repeat('-', max([40, strdisplaywidth(getline('.'))])))<CR>


