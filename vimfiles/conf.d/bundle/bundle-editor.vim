"--------------------------------------------------
" EdittingTools:
"-------------------------------------------------- 
NeoBundle 'rhysd/vim-grammarous'
NeoBundle 'ujihisa/neco-look'

NeoBundle 'Shougo/neocomplete.vim'  "{{{
if neobundle#tap('neocomplete.vim')
    " ステータスバー
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#text_mode_filetypes= {
                \ 'tex' : 1,
                \ 'markdown' : 1,
                \ 'plaintex' : 1
                \}
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#enable_auto_close_preview = 0
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }


    let g:neocomplete#sources#omni#input_patterns = {}
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    function! neobundle#hooks.on_source(bundle) "{{{
        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        function! s:my_cr_function()
            " return neocomplete#close_popup() . "\<CR>"
            "For no inserting <CR> key.
            return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " For cursor moving in insert mode(Not recommended)
        inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
        inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
        inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
        inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
        endfunction "}}}
    call neobundle#untap()
endif "}}}

NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neosnippet.vim' , {
            \  'depends' : "Shougo/neocomplete.vim"
            \}
let s:hooks = neobundle#get_hooks("neosnippet.vim")
function! s:hooks.on_source(bundle)
    augroup neosnippet_autocmd
        autocmd!
        autocmd InsertLeave * NeoSnippetClearMarkers
    augroup END
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)
    " SuperTab like snippets behavior.
    imap <expr><CR>  neosnippet#expandable() ? 
                \ "\<Plug>(neosnippet_expand)" : 
                \ pumvisible() ?  "\<C-Y>" : "\<CR>"
    imap <expr><TAB> pumvisible() ?  "\<C-n>" : 
                \  neosnippet#jumpable() ? 
                \ "\<Plug>(neosnippet_jump)"  : "\<TAB>" 
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory = [ '~/.vim/bundle/vim-snippets/snippets','~/.vim/snippets']
    let g:neosnippet#enable_preview = 0	 
    let g:neosnippet#disable_runtime_snippets = {
    \   'tex' : 1,
    \ }  

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endfunction 
unlet s:hooks
