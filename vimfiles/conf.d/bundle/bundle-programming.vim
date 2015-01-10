
"--------------------------------------------------
" Programming
"--------------------------------------------------
NeoBundle 'thinca/vim-quickrun'
nnoremap <silent> <Leader>r :QuickRun<CR>
nnoremap <silent><expr> <Leader>d ':QuickRun <input'. "<CR>"
nnoremap <silent> <Leader>se :QuickRun sql<CR>
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
                \ "_": {
                \   "runner"                    : "vimproc",
                \   "runner/vimproc/updatetime" : "60",
                \   "outputter/buffer/split"    : 'bot %{winwidth(0) * 2 > winheight(0) * 5 ? "" : "vertical"}',
                \}}
    let g:quickrun_config.sql ={
                \ 'command' : 'mysql',
                \ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
                \ 'exec'    : ['%c %o < %s' ] ,
                \}
    let g:quickrun_config['php.unit'] = {
                \ 'command': 'testrunner',
                \ 'cmdopt': 'phpunit'
                \} 
    let g:quickrun_config['python'] = {
                \ 'command': 'python',
                \}
    " let g:quickrun_config['python.unit'] = {i
    "             \ 'command': 'nosetests',
    "             \ 'cmdopt': '-v -s'
    "             \}
    let g:quickrun_config['python.pytest'] = {
                \ 'command': 'py.test',
                \ 'cmdopt': '-v'
                \}
    let g:quickrun_config.markdown  = {
                \ 'type' : 'markdown/pandoc',
                \ 'outputter' : 'browser'
                \ }
    let g:quickrun_config.html  = {
                \ 'command' : 'cygstart',
                \ 'cmdopt'  : '%c %o' ,
                \ 'outputter' : 'browser'
                \ }
    let g:quickrun_config['ruby.rspec']  = {
                \ 'command': 'rspec'
                \ , 'cmdopt': '-f d'
                \ }
    augroup QuickRunUnitTest
        autocmd!
        autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
        "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
        autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
        autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
        autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    augroup END

    function! MakeMySQLCommandOptions()
        if !exists("g:mysql_config_usr")
            let g:mysql_config_user = input("user> ")
        endif
        if !exists("g:mysql_config_host") 
            let g:mysql_config_host = input("host> ")
        endif
        if !exists("g:mysql_config_port")
            let g:mysql_config_port = input("port> ")
        endif
        if !exists("g:mysql_config_pass")
            let g:mysql_config_pass = inputsecret("password> ")
        endif
        if !exists("g:mysql_config_db") 
            let g:mysql_config_db = input("database> ")
        endif

        let optlist = []
        if g:mysql_config_user != ''
            call add(optlist, '-u ' . g:mysql_config_user)
        endif
        if g:mysql_config_host != ''
            call add(optlist, '-h ' . g:mysql_config_host)
        endif
        if g:mysql_config_db != ''
            call add(optlist, '-D ' . g:mysql_config_db)
        endif
        if g:mysql_config_pass != ''
            call add(optlist, '-p' . g:mysql_config_pass)
        endif
        if g:mysql_config_port != ''
            call add(optlist, '-P ' . g:mysql_config_port)
        endif
        if exists("g:mysql_config_otheropts")
            call add(optlist, g:mysql_config_otheropts)
        endif
        return join(optlist, ' ')
    endfunction 
endfunction 


"--------------------------------------------------
" Programming - Python
"--------------------------------------------------
" NeoBundleLazy 'ivanov/vim-ipython', {
"             \ 'autoload'    : {
"             \   'filetypes' : ['python', 'python3'],
"             \ },
"             \ }
" let s:hooks = neobundle#get_hooks('vim-ipython')
" function! s:hooks.on_source(bundle)
" endfunction
" unlet s:hooks

NeoBundleLazy 'alfredodeza/pytest.vim', {
            \ 'autoload'    : {
            \   'filetypes' : ['python', 'python3', 'pytest'],
            \ },
            \ 'build'       : {
            \   "cygwin"    : "pip install --user pytest",
            \   "mac"       : "pip install --user pytest",
            \   "unix"      : "pip install --user pytest"
            \}}
let s:hooks = neobundle#get_hooks("pytest.vim")
function! s:hooks.on_source(bundle)
    nnoremap  <silent><F5>      <Esc>:Pytest file verbose<CR>
    nnoremap  <silent><C-F5>    <Esc>:Pytest class verbose<CR>
    nnoremap  <silent><S-F5>    <Esc>:Pytest project verbose<CR>
    nnoremap  <silent><F6>      <Esc>:Pytest session<CR>
endfunction

NeoBundleLazy 'voithos/vim-python-matchit', {
            \ "autoload"    : {
            \   "filetypes" : ["python", "python3", "djangohtml"]
            \ }}

" NeoBundleLazy 'klen/python-mode', {
"              \ "autoload"    : {
"              \   "filetypes" : ["python", "python3", "djangohtml"],
"              \ },
"              \ "build"       : {
"              \   "cygwin"    : "pip install --user pylint rope pyflake pep8",
"              \   "mac"       : "pip install --user pylint rope pyflake pep8",
"              \   "unix"      : "pip install --user pylint rope pyflake pep8"
"              \ }}
" if neobundle#tap('python-mode')
"     let g:pymode = 1
"     let g:pymode_warnings = 1
"     let g:pymode_paths = ['shutil', 'datetime', 'time',
"                 \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
"     let g:pymode_trim_whitespaces = 1
"     let g:pymode_options = 1
"     let g:pymode_options_colorcolumn = 1
"     let g:pymode_quickfix_minheight = 3
"     let g:pymode_quickfix_maxheight = 6
"     let g:pymode_python = 'python'
"     " let g:pymode_indent = []
"     let g:pymode_folding = 1
"     let g:pymode_motion = 1

"     let g:pymode_doc = 1
"     let g:pymode_doc_bind = 'K'

"     " let g:pymode_virtualenv = 1
"     " let g:pymode_virtualenv_path = $VIRTUAL_ENV

"     let g:pymode_run = 0            "QuickRunの方が優秀
"     " let g:pymode_run_bind = '<leader>R'

"     let g:pymode_breakpoint = 1
"     let g:pymode_breakpoint_bind = '<leader>b'

"     let g:pymode_lint = 1
"     let g:pymode_lint_on_write = 1

"     "Check code on every save (every)
"     let g:pymode_lint_unmodified = 0
"     let g:pymode_lint_on_fly = 0
"     let g:pymode_lint_message = 1
"     " let g:pymode_lint_ignore = "E501,W"
"     " let g:pymode_lint_select = "E501,W0011,W430"
"     let g:pymode_lint_cwindow = 0

"     let g:pymode_rope = 0
"     let g:pymode_rope_autoimport = 1
"     let g:pymode_rope_autoimport_modules = ['shutil', 'datetime', 'time',
"                 \ 'sys', 'itertools', 'collections', 'os', 'functools', 're']
"     let g:pymode_rope_autoimport_import_after_complete = 0
"     let g:pymode_rope_organize_imports_bind = '<F11>'

"     let g:pymode_rope_goto_definition_bind = 'gf'
"     " let g:pymode_rope_goto_definition_cmd = 'botrightn new'

"     let g:pymode_rope_rename_bind = 'R'
"     " let g:pymode_rope_rename_module_bind = '<C-S-R>'

"     let g:pymode_rope_extract_method_bind = '<C-c>rm'
"     let g:pymode_rope_extract_variable_bind = '<C-c>rl'
"     let g:pymode_rope_use_function_bind = '<C-c>ru'

"     "よくわからない機能たち
"     " let g:pymode_rope_move_bind = '<C-c>rv'
"     " let g:pymode_rope_change_signature_bind = '<C-c>rs'
"     let g:pymode_lint_sort = ['E', 'C', 'I']  

"     nnoremap <silent><F8> :<C-u>PymodeLintAuto<CR>
"     nnoremap <silent><expr><leader>R  ":<C-u>VimShellInteractive --split='bot split \| resize 20' python ". expand('%').'<CR>'

"     augroup pymode_myautocmd
"         autocmd!
"         autocmd BufEnter __doc__ nnoremap <buffer>q  <C-w>c
"         autocmd BufEnter __doc____rope__ nnoremap <buffer>q  <C-w>c
"     augroup END

"     let g:pymode_syntax_slow_sync = 0
"     let g:pymode_syntax_all = 1
"     let g:pymode_syntax_print_as_function = 0
"     let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
"     let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
"     " Highlight 'self' keyword
"     let g:pymode_syntax_highlight_self           = g:pymode_syntax_all
"     " Highlight indent's errors
"     let g:pymode_syntax_indent_errors            = g:pymode_syntax_all
"     " Highlight space's errors
"     let g:pymode_syntax_space_errors             = g:pymode_syntax_all
"     " Highlight string formatting
"     let g:pymode_syntax_string_formatting        = g:pymode_syntax_all
"     let g:pymode_syntax_string_format            = g:pymode_syntax_all
"     let g:pymode_syntax_string_templates         = g:pymode_syntax_all
"     let g:pymode_syntax_doctests                 = g:pymode_syntax_all
"     " Highlight builtin objects (True, False, ...)
"     let g:pymode_syntax_builtin_objs             = g:pymode_syntax_all
"     " Highlight builtin types (str, list, ...)
"     let g:pymode_syntax_builtin_types            = g:pymode_syntax_all
"     " Highlight exceptions (TypeError, ValueError, ...)
"     let g:pymode_syntax_highlight_exceptions     = g:pymode_syntax_all
"     " Highlight docstrings as pythonDocstring (otherwise as pythonString)
"     let g:pymode_syntax_docstrings               = g:pymode_syntax_all

"     function! neobundle#hooks.on_source(bundle)
"     endfunction
"     call neobundle#untap()
" endif

NeoBundleLazy 'davidhalter/jedi-vim', {
             \ "autoload"    : {
             \   "filetypes" : ["python", "python3", "djangohtml"],
             \ },
             \ "build"       : {
             \   "cygwin"    : "pip install --user jedi",
             \   "mac"       : "pip install --user jedi",
             \   "unix"      : "pip install --user jedi"
             \ }}
if neobundle#tap('jedi-vim')
    " let g:jedi#completions_command = "<C-N>"
    " 自動設定機能をoffにし手動で設定を行う
    let g:jedi#auto_initialization  = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#auto_close_doc = 0
    " let g:jedi#show_call_signatures = 1

    "quickrunと被るため大文字に変更
    " let g:jedi#rename_command = 'R'
    " let g:jedi#goto_assignments_command = 'gf'
    " let g:jedi#goto_definitions_command = 'gd'
    " let g:jedi#use_tabs_not_buffers = 1
    " let g:jedi#completions_enabled = 1
    "
    " Configuration necocomplete, because of conflicts to one {{{
    if !exists('g:neocomplete#sources#omni#functions')
        let g:neocomplete#sources#omni#functions = {}
    endif
    let g:neocomplete#sources#omni#functions.python = 'jedi#completions'

    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#sources#omni#input_patterns.python = ''
    endif
    let g:neocomplete#force_omni_input_patterns.python = 
        \ '\%([^. \t]\{1,}\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

    "}}}

    function! neobundle#hooks.on_source(bundle)
        " If not setting this, set pythoncomplete to omnifunc, which is uncomfortable
        autocmd FileType python setlocal omnifunc=jedi#completions
        " autocmd FileType python setlocal omnifunc=jedi#completions
        call jedi#configure_call_signatures()
    endfunction
    call neobundle#untap()

endif
 

"--------------------------------------------------
" Programming - Web(HTML, CSS, Javascript, json)
"--------------------------------------------------
NeoBundleLazy 'mattn/emmet-vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html', 'css'],
            \ },}
let s:hooks = neobundle#get_hooks("emmet-vim")
function! s:hooks.on_source(bundle) 
    let g:user_emmet_leader_key = '<C-Y>'
endfunction

NeoBundleLazy 'vim-scripts/css_color.vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html','css'],
            \ },}

NeoBundleLazy 'hail2u/vim-css3-syntax', { 
            \ "autoload"    : {
            \   "filetypes" : ['css'],
            \ },}

NeoBundleLazy 'othree/html5.vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html', 'svg', 'rdf'],
            \ },}

NeoBundleLazy 'elzr/vim-json', { 
            \ "autoload"    : {
            \   "filetypes" : ['json'],
            \ },}
function! s:hooks.on_source(bundle) 
    let g:vim_json_syntax_conceal = 2
endfunction

"--------------------------------------------------
" Programming - Ruby
"--------------------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby', { 
            \ "autoload"    : {
            \   "filetypes" : ["ruby"],
            \ },}

"--------------------------------------------------
" Programming - LaTex
"--------------------------------------------------
NeoBundleLazy 'TKNGUE/vim-latex', {
            \ 'name' : 'vim-latex',
            \ "autoload": {
            \   "filetypes": ["tex"],
            \ }}
let g:tex_flavor = 'platex'
let s:hooks = neobundle#get_hooks("vim-latex")
function! s:hooks.on_source(bundle)
    set grepprg=grep\ -nH\ $*
    let g:tex_flavor='latex'
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_MultipleCompileFormats='pdf'
    " let g:Tex_FormatDependency_pdf = 'dvi,pdf'
    " let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_BibtexFlavor = 'upbibtex'
    let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
    " let g:Tex_UseEditorSettingInDVIViewer = 1
    " let g:Tex_ViewRule_pdf = 'xdg-open'
    " let g:Tex_ViewRule_pdf = 'evince_sync'
    let g:Tex_ViewRule_pdf = 'evince'
    "let g:Tex_ViewRule_pdf = 'okular --unique'
    "let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
    "let g:Tex_ViewRule_pdf = 'qpdfview --unique'
    "let g:Tex_ViewRule_pdf = 'texworks'
    "let g:Tex_ViewRule_pdf = 'mupdf'
    "let g:Tex_ViewRule_pdf = 'firefox -new-window'
    "let g:Tex_ViewRule_pdf = 'chromium --new-window'
    let g:Tex_IgnoreLevel = 9 
    let g:Tex_IgnoredWarnings = 
        \"Underfull\n".
        \"Overfull\n".
        \"specifier changed to\n".
        \"You have requested\n".
        \"Missing number, treated as zero.\n".
        \"There were undefined references\n".
        \"Citation %.%# undefined\n".
        \"LaTeX Font Warning: Font shape `%s' undefined\n".
        \"LaTeX Font Warning: Some font shapes were not available, defaults substituted."

    "キー配置の変更
    ""<Ctrl + J>はパネルの移動と被るので番うのに変える
    imap <C-n> <Plug>IMAP_JumpForward
    nmap <C-n> <Plug>IMAP_JumpForward
    vmap <C-n> <Plug>IMAP_DeleteAndJumpForward 
    " if !has('gui_running')
    "     set <m-i>=i
    "     set <m-b>=b
    "     set <m-l>=l
    "     set <m-c>=c
    " endif
endfunction


"--------------------------------------------------
" Programming - markdown
"--------------------------------------------------
" NeoBundleLazy 'Rykka/riv.vim' ,{
"             \ 'autoload'  :{
"             \   'filetypes' :
"             \      ['python', 'rst']
"             \}}
" let s:hooks = neobundle#get_hooks('Rykka/riv.vim')
" function! s:hooks.on_source(bundle)
" endfunction
" unlet s:hooks

NeoBundle 'rcmdnk/vim-markdown' , {  
            \ 'depends' : ['godlygeek/tabular', 'joker1007/vim-markdown-quote-syntax']
            \}
if neobundle#tap('vim-markdown')
    let g:vim_markdown_better_folding=1
    function! neobundle#hooks.on_source(bundle)
    endfunction
    call neobundle#untap()
endif

NeoBundle 'TKNGUE/hateblo.vim' ,{
            \ 'depends'  : ['mattn/webapi-vim', 'Shoug/unite.vim'],
            \}
let g:hateblo_config_path = '$HOME/.hateblo/.hateblo.vim'
let g:hateblo_dir = '$HOME/.hateblo/blog'

NeoBundleLazy 'TKNGUE/vim-reveal',{  
            \ "autoload"    : {
            \   "filetypes" : ['markdown'],  
            \},
            \}
let s:hooks = neobundle#get_hooks("vim-reveal")
function! s:hooks.on_source(bundle) 
    let g:reveal_root_path = '$HOME/work/reveal.js'
    let g:revel_default_config = {
                \ 'fname'  : 'reveal',
                \ 'key1'  : 'reveal'
                \ }
endfunction

NeoBundleLazy 'kannokanno/previm',{  
            \ "autoload"    : {
            \   "filetypes" : ['markdown'],  
            \ },
            \ "build"       : {
            \   "cygwin"    : "pip install --user docutils",
            \   "mac"       : "pip install --user docutils",
            \   "unix"      : "pip install --user docutils"
            \}}

NeoBundle 'clones/vim-zsh'
