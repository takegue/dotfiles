"--------------------------------------------------
" Unite-Source
"------------------------------------------------- 
NeoBundle 'Shougo/unite.vim'

let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    nnoremap [unite]    <Nop>
    nmap    <Leader>f  [unite]

    nnoremap  [unite]f  :<C-u>Unite source<CR>
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
    nnoremap <silent> [unite]b  :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]a  :<C-u>UniteBookmarkAdd<CR>   "bookmarkを追加可能に

    nnoremap <silent> [unite]gf :<C-u>Unite -buffer-name=search-buffer grep:%<CR>
    nnoremap <silent> [unite]gg :<C-u>Unite -buffer-name=search-buffer grep:./:-iR<CR>
    nnoremap <silent> [unite]gc :<C-u>Unite -buffer-name=search-buffer grep:$buffers::<C-R><C-W><CR>
    nnoremap <silent> [unite]R  :<C-u>Unite -buffer-name=resume resume<CR>

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
        nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
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
        let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
        let g:unite_source_grep_recursive_opt = ''

        let g:unite_source_rec_async_command =
                \ 'ag --follow --nocolor --nogroup --hidden -g ""'
    endif
endfunction

NeoBundle 'Shougo/unite-outline', {
            \ "depends": ["Shougo/unite.vim"],
            \ } 
let s:hooks = neobundle#get_hooks("unite-outline")
function! s:hooks.on_source(bundle) 
    nnoremap <silent> <Leader>o :<C-u>botright Unite -vertical -no-quit -winwidth=40 -direction=botright outline<CR> 
endfunction

NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tsukkee/unite-help'
" nnoremap <silent> :<C-u>Unite -start-insert help<CR>
nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

NeoBundle 'Shougo/neossh.vim', {
            \ "depends": ['Shougo/unite.vim']
            \}

" 'Advent Calendarまとめ'
NeoBundle 'mattn/unite-advent_calendar', {
            \ "depends": ['tyru/open-browser.vim', 'mattn/webapi-vim'],
            \}

NeoBundleLazy 'Shougo/vimfiler.vim', {
            \ "autoload": {
            \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
            \   "mappings": ['<Plug>(vimfiler_switch)'],
            \   "explorer": 1,
            \ }} 
nnoremap <Leader>e :VimFilerExplorer<CR>
nnoremap <Leader>E :VimFiler<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler.vim")
function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1

    " 2013-08-14 追記
    let g:vimfiler_ignore_pattern = '\(\.git\|\.DS_Store\|.pyc\|\%^\..\+\)\%$'

    " vimfiler specific key mappings
    autocmd MyAutoCmd FileType vimfiler call <SID>vimfiler_settings()
    function! s:vimfiler_settings()
        " ^^ to go up 
        nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
        " use R to refresh
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        " overwrite C-l
        nmap <buffer> <C-l> <C-w>l
    endfunction
endfunction

NeoBundle 'tacroe/unite-mark', {
            \ "depends": ["Shougo/unite.vim"]
            \ } 


