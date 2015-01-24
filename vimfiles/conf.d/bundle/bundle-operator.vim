"--------------------------------------------------
" Vim-Operator
"------------------------------------------------- 
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'

NeoBundle 'tpope/vim-commentary'                        "コメント切り替えオペレータ
NeoBundle 'tpope/vim-surround'                          "surround記号編集オペレータ
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-unimpaired'                        "バッファ移動用等
"sort用オtpope/vim-operator-userペレータ
NeoBundle 'emonkak/vim-operator-sort', {                
            \ 'depends' : ['tpope/vim-operator-user']   
            \}
NeoBundle 'pekepeke/vim-operator-tabular', {
            \ 'depends' : ['pekepeke/vim-csvutil'] 
            \}
NeoBundle 'wellle/targets.vim'


" NeoBundle 'AndrewRadev/switch.vim'                     "true ⇔ falseなどの切り替え
NeoBundle 'TKNGUE/switch.vim'                           "true ⇔ falseなどの切り替え
let s:hooks = neobundle#get_hooks('switch.vim')
function! s:hooks.on_source(bundle)
    nnoremap - :Switch<CR>
    augroup switch_autocmd
        autocmd FileType gitrebase let b:switch_custom_definitions = [
                    \ ['pick' , 'reword', 'edit'  , 'squash' , 'fixup' , 'exec'],
                    \]

        autocmd FileType python let b:switch_custom_definitions =
            \[
            \   ['and', 'or'],
            \   {
            \     '\(.\+\) if \(.\+\) else \(.\+\)' : { 
            \        '\(\s*\)\(.\+\) = \(.\+\) if \(.\+\) else \(.\+\)' : 
            \             '\1if \4:\1    \2 = \3\1else:\1    \2 = \4'
            \      }
            \   },
            \]
    augroup end
    let g:switch_custom_definitions =
        \ [
        \   ['!=', '=='],
        \   {
        \     '>\(=\)\@!'  : '>=',
        \     '>='  : '<',
        \     '<\(=\)\@!'  : '<=',
        \     '<='  : '>',
        \   },
        \   {
        \     '\<[a-z0-9]\+_\k\+\>': { 
        \       '_\(.\)': '\U\1',
        \       '\<\(.\)': '\U\1'
        \     },
        \     '\<[A-Za-z][a-z0-9]\+[A-Z]\k\+\>': {
        \       '\(\u\)': '_\l\1',
        \       '\<_': ''
        \     },
        \   }
        \ ]
endfunction
unlet s:hooks

