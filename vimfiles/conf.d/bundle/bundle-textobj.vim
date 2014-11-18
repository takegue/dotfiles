"--------------------------------------------------
" Vim-TextObj
"------------------------------------------------- 
NeoBundle "kana/vim-textobj-user"
NeoBundle 'sgur/vim-textobj-parameter'                  "引数オブジェクト #a, i,

NeoBundle "kana/vim-textobj-entire"                     "全体選択オブジェクト   #ae, ai
NeoBundle "kana/vim-textobj-datetime"                   "日付選択オブジェクト   #ada, add, adt
NeoBundle "thinca/vim-textobj-comment"                  "コメントオブジェクト   #ac, ic×
NeoBundle "mattn/vim-textobj-url"                       "URLオブジェクト        #au, iu
NeoBundle "rbonvall/vim-textobj-latex"                  "LaTeXオブジェクト      #
"関数オブジェクト(C, Java, Vim)
NeoBundleLazy 'kana/vim-textobj-function', {
            \ 'script_ytype' : 'ftplugin',
            \ 'autoload' : {
            \   'filetypes' : ['cpp', 'java', 'vim']
            \}}
NeoBundleLazy 'bps/vim-textobj-python', {
            \ 'script_ytype' : 'ftplugin',
            \ 'autoload' : {
            \   'filetypes' : ['python', 'pytest']
            \}}
NeoBundle 'michaeljsmith/vim-indent-object'             "同Indentオブジェクト   #ai. ii, aI, iI
