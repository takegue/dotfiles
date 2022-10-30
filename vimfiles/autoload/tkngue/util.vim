" File: util.vim
" Author: TKNGUE
" Description: My utilities
" Last Modified: 10月 24, 2016
"
let s:_executable = {}
function! tkngue#util#executable(expr) abort
  let s:_executable[a:expr] = has_key(s:_executable, a:expr) ?
        \ s:_executable[a:expr] : executable(a:expr)
  return s:_executable[a:expr]
endfunction

function! tkngue#util#detect_project() abort
    let l:language_cues = {
          \ "git": {
          \   "priority" : 0,
          \   "files": [],
          \   "directories": [".git"],
          \ },
          \ "rust/cargo": {
          \   "priority" : 10,
          \   "files": ["Cargo.toml", "Cargo.lock"],
          \ },
          \ "python": {
          \   "priority" : 10,
          \   "files": ["Pipfile", "requiments.txt"],
          \ },
          \ "node": {
          \   "priority" : 10,
          \   "files": ["package-lock.json", "package.json"],
          \ },
          \ "php": {
          \   "priority" : 10,
          \   "files": ["composer.json","composer.lock"],
          \ },
          \ }

    let file2lang = {}
    for [l:lang, l:config] in items(l:language_cues)
      let l:file2lang[lang] = config

    endfor

    let l:searching = sort(items(l:file2lang), {lhs, rhs -> lhs[1].priority < rhs[1].priority})

    let l:search_path = expand('%:p:h') . ';'
    for [l:lang, l:config] in l:searching
      for l:file in get(l:config, "files", [])
        let l:result = findfile(l:file, l:search_path)
        if l:result == ''
          continue
        endif

        return [
              \ fnamemodify(l:result, ":p:h"),
              \ l:lang,
              \ fnamemodify(l:result, ":p:t")
              \ ]
      endfor

      for l:dir in get(l:config, "directories", [])
        let l:result = finddir(l:dir, l:search_path)
        return [
              \ fnamemodify(l:result, ":p:h:h"),
              \ l:lang,
              \ l:lang,
              \ ]
      endfor
    endfor

    return ['', '', '']
endfunction

function! tkngue#util#toggle_windowsize() abort
  if !exists('t:restcmd')
    let t:restcmd = ''
  endif
  if t:restcmd  != ''
    exe t:restcmd
    let t:restcmd = ''
  else
    let t:restcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction

function! tkngue#util#system(cmd) abort
  " let l:h = sha256(a:cmd)
  let l:h = shellescape(substitute(a:cmd, ' ', '', 'g'))
  " let l:path = stdpath('cache') . '/' . l:h
  let l:cache_path = '/tmp/vim/'
  let l:path = '/tmp/vim/' . l:h

  if !isdirectory(l:cache_path)
    call mkdir(l:cache_path)
  endif

  if !filereadable(l:path)
    let l:output = system(a:cmd)
    call writefile(split(l:output, '\n'), l:path)
  else
    let l:output = join(readfile(l:path), '\n')
  endif
  return l:output
endfunction


function! tkngue#util#open_folder_of_currentfile() abort
  let l:path = escape(expand("%:p:h"),' ()')
  if has('unix') && tkngue#util#executable('xdg-open')
    call system( 'xdg-open '. path)
  elseif has('mac') && tkngue#util#executable('open')
    call system('open '. path)
  endif
endfunction

function! tkngue#util#is_binary() abort
  return !!search('\%u0000', 'wn')
endfunction


function! tkngue#util#open_junk_file(type) abort
  " execute "%d a"
  "
  let l:junk_basedir = $HOME . '/Dropbox/junks'
  if getenv("JUNK") != ''
    let l:junk_basedir = getenv("JUNK")
    echomsg l:junk_basedir
  endif
  let l:junk_dir = l:junk_basedir . strftime('/%Y/%m')

  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif
  if a:type == ''
    let l:filename = input('Junk Code: ', l:junk_dir . strftime('/%Y-%m-%d-%H%M%S__'))
  else
    let l:filename = l:junk_dir . strftime('/%Y-%m-%d-%H%M%S.') . a:type
  endif

  let l:filename = substitute(l:filename, '__\/', '/', 'g')
  if l:filename != ''
    execute 'edit ' . l:filename
  endif

  lcd %:p:h
endfunction

function! tkngue#util#open_todofile() abort
  let l:path  =  "~/.todo"
  if filereadable(expand("~/Dropbox/.todo"))
    let l:path = expand("~/Dropbox/.todo")
  endif
  if bufwinnr(l:path) < 0
    execute 'silent bo 60vs +set\ nonumber ' . l:path
  endif
  unlet! l:path
endfunction


function! tkngue#util#test_plugin(is_gui, extracCommand) abort
  let cmd = a:is_gui ? 'gvim' : 'vim'
  let extraCommand = escape(a:extraCommand, '!\<>"')
  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * nested ' . extraCommand . '"'
  if exists('b:git_dir')
    let l:additional_path = shellescape(fnamemodify(b:git_dir, ':p:h:h'))
  else
    let l:additional_path = shellescape(fnamemodify(getcwd(), ':p:h:h'))
  endif
  execute '!' . cmd . ' -u ~/.min.vimrc -i NONE -N --cmd "set rtp+=' . additional_path . '"' . extraCommand
endfunction


function! tkngue#util#switch_to_actualfile() abort
  let l:fname = resolve(expand('%:p'))
  let l:pos = getpos('.')
  let l:bufname = bufname('%')
  enew
  exec 'bw '. l:bufname
  exec "e" . fname
  call setpos('.', pos)
endfunction


function! tkngue#util#toggle_line_numbers() abort
  if exists('+relativenumber')
    if (v:version >= 704)
      " Toggle between relative with absolute on cursor line and no numbers.
      let l:mapping = [[[0,1],[1,1]],[[1,1],[0,0]]]
      " let [&l:relativenumber, &l:number] =
      "       \ (&l:relativenumber || &l:number) ? [0, 0] : [1, 1]
      let [&l:relativenumber, &l:number] = l:mapping[&l:relativenumber][&l:number]
    else
      " Rotate absolute => relative => no numbers.
      execute 'setlocal' (&l:number == &l:relativenumber) ?
            \ 'number! number?' : 'relativenumber! relativenumber?'
    endif
  else
    setlocal number! number?
  endif
endfunction


function! tkngue#util#restore_curosr_position() abort
  let ignore_filetypes = ['gitcommit']
  if index(ignore_filetypes, &l:filetype) >= 0
    return
  endif

  if line("'\"") > 1 && line("'\"") <= line("$")
    execute 'normal! g`"'
  endif
  try
    normal! zMzvzz
  catch /E490/
  endtry
endfunction

function! tkngue#util#change_current_dirr(directory, bang) abort
  if a:directory == ''
    execute 'lcd ' . escape(expand('%:p:h'), ' ()')
  else
    execute 'lcd ' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! tkngue#util#mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! tkngue#util#intaractive_mkdir(input) abort
  let path = input('mkdir>', a:input)
  call tkngue#util#mkdir(path, 1)
endfunction


function! tkngue#util#load_webpage(url) abort
  execute 'r !wget -O - '.a:url.' 2>/dev/null'
endfunction

function! tkngue#util#show_current_function() abort
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfunction

function! tkngue#util#get_diff_files(rev) abort
  let s:git_status_dictionary = {
        \ "A": "Added",
        \ "B": "Broken",
        \ "C": "Copied",
        \ "D": "Deleted",
        \ "M": "Modified",
        \ "R": "Renamed",
        \ "T": "Changed",
        \ "U": "Unmerged",
        \ "X": "Unknown"
        \ }
  let list = map(split(system(
        \ 'git diff --name-status '.a:rev), '\n'),
        \ '{"filename":matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
        \ )
  call setqflist(list)
  copen
endfunction
