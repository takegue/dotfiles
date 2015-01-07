"--------------------------------------------------
" Unite-Source
"------------------------------------------------- 
" Shougo/unite.vim {{{
NeoBundle 'Shougo/unite.vim' 
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    nnoremap [unite]    <Nop>
    nmap    <Leader>f  [unite]
    nnoremap  [unite]f  :<C-u>Unite buffer file file_mru<CR>
    " nnoremap  [unite]f  :<C-u>Unite source<CR>
    nnoremap <silent> [unite]s
                \ :<C-u>Unite -buffer-name=files -no-split
                \ jump_point file_point buffer_tab
                \ file_rec:! file file/new<CR>
    nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir 
                \ -buffer-name=files buffer bookmark file<CR>
    nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
                \ -buffer-name=files -prompt=%\  buffer bookmark file<CR>
    nnoremap <silent> [unite]r  :<C-u>Unite
                \ -buffer-name=register register<CR>
    nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]ma :<C-u>Unite mapping<CR>
    nnoremap <silent> [unite]me :<C-u>Unite output:message<CR>
    " nnoremap <silent> [unite]b  :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]a  :<C-u>UniteBookmarkAdd<CR>   "bookmarkを追加可能に

    nnoremap <silent> [unite]gf :<C-u>Unite -buffer-name=search-buffer grep:%<CR>
    nnoremap <silent> [unite]gg :<C-u>Unite -buffer-name=search-buffer grep:./:-iR<CR>
    nnoremap <silent> [unite]gc :<C-u>Unite -buffer-name=search-buffer grep:$buffers::<C-R><C-W><CR>
    nnoremap <silent> [unite]R  :<C-u>Unite -buffer-name=resume resume<CR>
    nnoremap <silent> [unite]<C-h>  :<C-u>Unite -buffer-name=help help<CR>
    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord -buffer-name=help help<CR>

    " Start insert.
    "call unite#custom#profile('default', 'context', {
    "\   'start_insert': 1
    "\ })

    " Like ctrlp.vim settings.
    "call unite#custom#profile('default', 'context', {
    "\   'start_insert': 1,
    "\   'winheight': 10,
    "\   'direction': 'botright',
    "\ })

    " Prompt choices.
    "call unite#custom#profile('default', 'context', {
    "\   'prompt': '» ',
    "\ })

    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings() "{{{
        " Overwrite settings.
        imap <buffer> jj      <Plug>(unite_insert_leave)
        "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

        imap <buffer><expr> j unite#smart_map('j', '')
        imap <buffer> <TAB>   <Plug>(unite_select_next_line)
        imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
        imap <buffer> '     <Plug>(unite_quick_match_default_action)
        nmap <buffer> '     <Plug>(unite_quick_match_default_action)
        imap <buffer><expr> x
                \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
        nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
        nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
        imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
        imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        " nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
        nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
        imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
        nnoremap <silent><buffer><expr> l
                \ unite#smart_map('l', unite#do_action('default'))

        let unite = unite#get_current_unite()
        if unite.profile_name ==# 'search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
        else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
        endif

        nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
        nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
                \ empty(unite#mappings#get_current_filters()) ?
                \ ['sorter_reverse'] : [])

        " Runs "split" action by <C-s>.
        imap <silent><buffer><expr> <C-s>     unite#do_action('split')
    endfunction "}}}

    " mappingが競合するためデフォルトマッピング無効
    " let g:unite_no_default_keymappings = 1
    " nnoremap <silent> <Plug>(unite_exit)
    "
    " unite grep に ag(The Silver Searcher) を使う
    if executable('ag')
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts = 
                    \ '--nogroup --nocolor --column'
        let g:unite_source_grep_recursive_opt = ''

        let g:unite_source_rec_async_command =
                    \ 'ag --follow --nocolor --nogroup --hidden -g ""'
    endif
endfunction
"}}}

" Shougo/vimfiler.vim, {{{
NeoBundleLazy 'Shougo/vimfiler.vim', {
            \ "autoload": {
            \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
            \   "mappings": ['<Plug>(vimfiler_switch)'],
            \   "explorer": 1,
            \ }} 
if neobundle#tap('vimfiler.vim')
    " Enable file operation commands.
    " Edit file by tabedit.
    "call vimfiler#custom#profile('default', 'context', {
    "      \ 'safe' : 0,
    "      \ 'edit_action' : 'tabedit',
    "      \ })

    " Like Textmate icons.

    " Use trashbox.
    " Windows only and require latest vimproc.
    "let g:unite_kind_file_use_trashbox = 1
    nnoremap <Leader>e :VimFilerExplorer<CR>
    nnoremap <Leader>E :VimFiler<CR>
    augroup vimfile_options
        " this one is which you're most likely to use?
        autocmd FileType vimfiler call <SID>vimfiler_settings()
        autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    augroup end

    function! neobundle#hooks.on_source(bundle)
        let g:vimfiler_ignore_pattern = '\(\.git\|\.DS_Store\|.py[co]\|\%^\..\+\)\%$'
        let g:vimfiler_tree_leaf_icon = ' '
        let g:vimfiler_tree_opened_icon = '▾'
        let g:vimfiler_tree_closed_icon = '▸'
        let g:vimfiler_file_icon = ' '
        let g:vimfiler_marked_file_icon = '*'
        let g:vimfiler_enable_auto_cd = 1
        let g:vimfiler_as_default_explorer = 1
        let g:unite_kind_openable_lcd_command='lcd'
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_split_rule="botright"

        call vimfiler#set_execute_file('txt', 'notepad')
        call vimfiler#set_execute_file('c', ['gvim', 'notepad'])
        call vimfiler#custom#profile('default', 'auto-cd', 'lcd')

        " vimfiler specific key mappings
        function! s:vimfiler_settings()
            " ^^ to go up 
            nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
            " use R to refresh
            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
            " overwrite C-l
            nmap <buffer> <C-l> <C-w>l
        endfunction
    endfunction

    call neobundle#untap()
endif "}}}

" Other unite sources {{{
NeoBundle 'Shougo/unite-outline', {
            \ "depends": ["Shougo/unite.vim"],
            \ } 
if neobundle#tap('unite-outline')
    nnoremap <silent> <Leader>o :<C-u>botright Unite -vertical -no-quit -winwidth=40 -direction=botright outline<CR> 
    call neobundle#untap()
endif
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'Shougo/neossh.vim', {
            \ "depends": ['Shougo/unite.vim']
            \}
" 'Advent Calendarまとめ'
NeoBundle 'mattn/unite-advent_calendar', {
            \ "depends": ['tyru/open-browser.vim', 'mattn/webapi-vim'],
            \}

" close vimfiler automatically when there are only vimfiler open
NeoBundle 'tacroe/unite-mark', {
            \ "depends": ["Shougo/unite.vim"]
            \ } 
"}}}



