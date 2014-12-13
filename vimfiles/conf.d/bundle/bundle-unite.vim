"--------------------------------------------------
" Unite-Source
"------------------------------------------------- 
NeoBundle 'Shougo/unite.vim'
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    nnoremap [unite]    <Nop>
    nmap    <Leader>f  [unite]
    nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file file_mru<CR>
    nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>   "bookmarkを追加可能に
    nnoremap <silent> [unite]gf  :<C-u>Unite grep:% -buffer-name=search-buffer<CR>
    nnoremap <silent> [unite]gg  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    nnoremap <silent> [unite]gc :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>l<BS>
    nnoremap <silent> [unite]r  :<C-u>UniteResume search-buffer<CR>
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


