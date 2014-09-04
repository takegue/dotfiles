"--------------------------------------------------
" Vim-Operator
"------------------------------------------------- 
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'tpope/vim-commentary'                        "コメント切り替えオペレータ
NeoBundle 'tpope/vim-surround'                          "surround記号編集オペレータ
"sort用オtpope/vim-operator-userペレータ
NeoBundle 'emonkak/vim-operator-sort', {                
            \ 'depends' : ['tpope/vim-operator-user']   
            \}
NeoBundle 'pekepeke/vim-operator-tabular', {
            \ 'depends' : ['pekepeke/vim-csvutil'] 
            \}
NeoBundle 'tyru/operator-camelize.vim'                  "Camelizeまたはdecamelize(snake_case) オペレータ
map gC <Plug>(operator-camelize)
map gS <Plug>(operator-decamelize)
NeoBundle 'yomi322/vim-operator-suddendeath'            "突然の死ジェネレータ
NeoBundle 'AndrewRadev/switch.vim'                      "true ⇔ falseなどの切り替え
nnoremap - :Switch<CR>

