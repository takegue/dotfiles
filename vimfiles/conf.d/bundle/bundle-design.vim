"---------------------------------------------------
" Design: mainly setting the vim design
"-------------------------------------------------- 
"
" nathanaelkane/vim-indent-guides' : indent guide用のプラグイン{{{
NeoBundle 'nathanaelkane/vim-indent-guides'  
if neobundle#tap('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1 
    let g:indent_guides_default_mapping = 1
    augroup indent_guides
        autocmd!
        " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
        " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238 
    augroup END
    function! neobundle#hooks.on_source(bundle)
    endfunction
    call neobundle#untap()
endif "}}}


 "{{{ itchyny/lightline.vim : mstatusline用のプラグイン
NeoBundle 'itchyny/lightline.vim' 
if neobundle#tap('lightline.vim')
    function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction 

    function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ?  '⭤' : ''
    endfunction
    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction 

    function! MyFugitive()
        try
            if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#statusline')
                let _ = substitute(fugitive#statusline(),'\[Git:\?\(.\+\)\]', '\1', 'g')
                let _ = substitute(_,'^(\(.\+\))$', '\1', 'g')
                return strlen(_) ? '⭠ '._ : ''
            endif
        catch
        endtry
        return ''
    endfunction
    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction
    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction
    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction
    function! MyCount()
        if mode() =~ '[vV]\|CTRL-V\|'
            return sumit#count_selected_text()
        else  
            return ''
        endif
    endfunction  
    function! MyMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction  

    let g:lightline = {
                \ 'colorscheme': 'powerline',
                \ 'mode_map': {'c': 'COMMAND'},
                \ 'active': {
                \   'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
                \   'right': [ [ 'lineinfo' ],
                \              [ 'percent' ],
                \              [ 'fileformat', 'fileencoding', 'filetype' ],
                \              [ 'count'] ],
                \ },
                \ 'component': {
                \   'lineinfo': '%3l:%-2v',
                \ },
                \ 'component_function': {
                \   'modified': 'MyModified',
                \   'readonly': 'MyReadonly',
                \   'fugitive': 'MyFugitive',
                \   'count': 'MyCount',
                \   'filename': 'MyFilename',
                \   'fileformat': 'MyFileformat',
                \   'filetype': 'MyFiletype',
                \   'fileencoding': 'MyFileencoding',
                \   'mode': 'MyMode'
                \ },
                \ 'component_visible_condition' :{
                \   'modified': '&modified||!&modifiable',
                \   'readonly': '&readonly'
                \ },
                \ 'separator': { 'left': '⮀', 'right': '⮂' },
                \ 'subseparator': { 'left': '⮁', 'right': '⮃' }} 
    function! neobundle#hooks.on_source(bundle)
    endfunction
    call neobundle#untap()
endif
