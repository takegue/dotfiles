"--------------------------------------------------
" VimShell 
"------------------------------------------------- 
NeoBundleLazy 'Shougo/vimshell', {
            \ 'autoload' : {
            \   'commands' : ['VimShell']
            \ }}
nnoremap <silent> <Leader>vs :VimShell<CR>
nnoremap <silent> <Leader>vsc :VimShellCreate<CR>
nnoremap <silent> <Leader>vp :VimShellPop<CR>
let s:hooks = neobundle#get_hooks('vimshell')
function! s:hooks.on_source(bundle)
    " vimshell setting
    let g:vimshell_interactive_update_time = 10
    " vimshell map
    "let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    let g:vimshell_right_prompt = 'fnamemodify(getcwd(), ":p:~")'

    if has('win32') || has('win64')
        " Display user name on Windows.
        let g:vimshell_prompt = $USERNAME."% "
    else
        " Display user name on Linux.
        let g:vimshell_prompt = $USER."% ". $HOST
    endif

    " Initialize execute file list.
    let g:vimshell_execute_file_list = {}
    call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
    let g:vimshell_execute_file_list['rb'] = 'ruby'
    let g:vimshell_execute_file_list['pl'] = 'perl'
    let g:vimshell_execute_file_list['py'] = 'python'
    call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

    autocmd FileType vimshell
                \ call vimshell#altercmd#define('g', 'git')
                \| call vimshell#altercmd#define('i', 'iexe')
                \| call vimshell#altercmd#define('l', 'll')
                \| call vimshell#altercmd#define('ll', 'ls -l')
                \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')

    function! MyChpwd(args, context)
        call vimshell#execute('ls')
    endfunction

    autocmd FileType int-* call s:interactive_settings()
    function! s:interactive_settings()
    endfunction

endfunction

NeoBundle 'aperezdc/vim-template' 
" let g:templates_plugin_loaded = 1 
" let g:templates_no_autocmd = 1 
" let g:templates_name_prefix = ".vimtemplate."
" let g:templates_global_name_prefix = "template:"
" let g:templates_debug = 1 

NeoBundle 'vim-scripts/Align'
"NeoBundle 'vim-scripts/YankRing.vim'
"
NeoBundle 'osyo-manga/vim-over'
let g:over_enable_cmd_windw = 1
" over.vimの起動  
nnoremap <silent> <Leader>m :OverCommandLine<CR> 
" " カーソル下の単語をハイライト付きで置換
" nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left> 
" " コピーした文字列をハイライト付きで置換
" nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left> 
"

"WORD移動用文書区切り用
NeoBundle "deton/jasegment.vim" 

"TODO:便利そうだけど使ってない
NeoBundleLazy 'kana/vim-smartchr', { 
            \ "autoload": {
            \   "filetypes": ["tex"],
            \ }} 

NeoBundle 'xolox/vim-session', {
            \ 'depends' : 'xolox/vim-misc',
            \ } 
let s:hooks = neobundle#get_hooks("vim-session")
function! s:hooks.on_source(bundle) 
    " 現在のディレクトリ直下の .vimsessions/ を取得 
    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
    if isdirectory(s:local_session_directory)
        " session保存ディレクトリをそのディレクトリの設定
        let g:session_directory = s:local_session_directory
        " vimを辞める時に自動保存
        let g:session_autosave = 'yes'
        " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
        let g:session_autoload = 'yes'
        " 1分間に1回自動保存
        let g:session_autosave_periodic = 1
    else
        let g:session_autosave = 'no'
        let g:session_autoload = 'no'
    endif
    unlet s:local_session_directory

    command! MkDirSession call s:mk_dirsession()
    function! s:mk_dirsession()    "session用のディレクトリ作成関数
        let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
        call mkdir(s:local_session_directory)
        let g:session_directory = s:local_session_directory
        unlet s:local_session_directory
    endfunction
endfunction 

NeoBundle 'tpope/vim-fugitive'          "Git操作用 プラグイン
command! FollowSymlink call s:SwitchToActualFile()
function! s:SwitchToActualFile()
    let fname = resolve(expand('%:p'))
    let pos = getpos('.')
    bwipeout %
    exec "e" . fname
    call setpos('.', pos)
endfunction


