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

NeoBundle 'thinca/vim-template' 
autocmd User plugin-template-loaded call s:template_keywords()
autocmd User plugin-template-loaded 
            \    if search('<+CURSOR+>')
            \  |   execute 'normal! "_da>'
            \  | endif

function! s:template_keywords()
    silent! %s/<+FILE NAME+>/\=expand('%:t')/g
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+MONTH+>/\=strftime('%m')/g
    " And more...
endfunction

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
if neobundle#tap('vim-fugitive')
    function! ConfigOnGitRepository()
        if !exists('b:git_dir')
            return
        endif
        nnoremap <buffer> [git] <Nop>
        nmap <buffer> <Leader>g [git]
        nnoremap <buffer> [git]c :<C-u>Gcommit<CR>
        nnoremap <buffer> [git]C :<C-u>Gcommit --amend<CR>
        nnoremap <buffer> [git]w :<C-u>Gwrite<CR>
        nnoremap <buffer> [git]s :<C-u>Gstatus<CR>
        nnoremap <buffer> [git]d :<C-u>Gdiff<CR>
        nnoremap <buffer> [git]p :<C-u>Gpush<CR>
        nnoremap <buffer> [git]P :<C-u>Gpull<CR>
    endfunction
    function! neobundle#hooks.on_source(bundle)
        augroup FUGITIVE
            autocmd!
            autocmd BufReadPost * call ConfigOnGitRepository()
        augroup END
    endfunction
    call neobundle#untap()
endif

command! FollowSymlink call s:SwitchToActualFile()
function! s:SwitchToActualFile()
    let l:fname = resolve(expand('%:p'))
    let l:pos = getpos('.')
    let l:bufname = bufname('%')
    enew
    exec 'bw '. l:bufname
    exec "e" . fname
    call setpos('.', pos)
endfunction

NeoBundle 'tpope/vim-repeat'

NeoBundle 'christoomey/vim-tmux-navigator'

NeoBundle 'christoomey/vim-tmux-navigator'
let s:hooks = neobundle#get_hooks('vim-tmux-navigator')
function! s:hooks.on_source(bundle)
    let g:tmux_navigator_save_on_switch = 1
    " " let g:tmux_navigator_no_mappings = 1
    " nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
    " nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
    " nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
    " nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
    " nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
endfunction
unlet s:hooks


NeoBundle 'Lokaltog/vim-easymotion'   "{{{ 高速移動用マッピング
if neobundle#tap('vim-easymotion')
    " =======================================
    " Boost your productivity with EasyMotion
    " =======================================
    " Disable default mappings
    " If you are true vimmer, you should explicitly map keys by yourself.
    " Do not rely on default bidings.
    let g:EasyMotion_do_mapping = 0

    " Or map prefix key at least(Default: <Leader><Leader>)
    " map <Leader> <Plug>(easymotion-prefix)

    " =======================================
    " Find Motions
    " =======================================
    " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
    " `s{char}{char}{target}`
    " map <Leader>f <Plug>(easymotion-fl)
    " map <Leader>F <Plug>(easymotion-Fl)
    " map <Leader>t <Plug>(easymotion-tl)
    " map <Leader>T <Plug>(easymotion-Tl)
    nmap gs <Plug>(easymotion-s2)
    xmap gs <Plug>(easymotion-s2)
    omap z <Plug>(easymotion-s2)
    " Of course, you can map to any key you want such as `<Space>`
    " map <Space>(easymotion-s2)

    " Turn on case sensitive feature
    let g:EasyMotion_smartcase = 1

    " =======================================
    " Line Motions
    " =======================================
    " `JK` Motions: Extend line motions
    map gj <Plug>(easymotion-j)
    map gk <Plug>(easymotion-k)
    " keep cursor column with `JK` motions
    let g:EasyMotion_startofline = 0

    " =======================================
    " General Configuration
    " =======================================
    let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
    " Show target key with upper case to improve readability
    let g:EasyMotion_use_upper = 1
    " Jump to first match with enter & space
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1

    " =======================================
    " Search Motions
    " =======================================
    " Extend search motions with vital-over command line interface
    " Incremental highlight of all the matches
    " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
    " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
    " :h easymotion-command-line
    nmap g/ <Plug>(easymotion-sn)
    xmap g/ <Plug>(easymotion-sn)
    omap g/ <Plug>(easymotion-tn)

    function! neobundle#hooks.on_source(bundle)

    endfunction
    call neobundle#untap()
endif
"}}}
