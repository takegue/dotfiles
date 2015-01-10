"-------------------------------------------------- 
" Key Mapping
"-------------------------------------------------- 
"<Leader>を,に変更
let mapleader=','
let maplocalleader='\'

"素早くjj と押すことでESCとみなす
" inoremap jj <Esc>
" nnoremap ; q:a
" nnoremap ; :
" nnoremap : q:i
" nnoremap Q q
" nnoremap q <Nop> 
" nnoremap q: q: 
"
nnoremap Y y$
nnoremap & g&

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc>    :noh<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nnoremap g; g;zz
nnoremap g, g,zz

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
" nnoremap <Tab> %
" vnoremap <Tab> %

" matchitを有効にする.
source $VIMRUNTIME/macros/matchit.vim

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-W><C-z> :call ToggleWindowSize()<CR>
nnoremap <C-W>z :call ToggleWindowSize()<CR>

function! ToggleWindowSize()
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

nnoremap <silent><C-F> :<C-U>setl lazyredraw<CR><C-D><C-D>:setl nolazyredraw<CR>
nnoremap <silent><C-B> :<C-U>setl lazyredraw<CR><C-U><C-U>:setl nolazyredraw<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

nnoremap <Left>     <Nop>
nnoremap <Right>    <Nop>
nnoremap <Up>       <Nop>
nnoremap <Down>     <Nop>

nnoremap <C-Left>     <Nop>
nnoremap <C-Right>    <Nop>
nnoremap <C-Up>       <Nop>
nnoremap <C-Down>     <Nop>

"
if has('gui_running')
    nnoremap <silent> <Space>.  :<C-u>tabnew $MYVIMRC<CR>:<C-u>vs $MYGVIMRC<CR>
else
    nnoremap <silent> <Space>.  :<C-u>e $MYVIMRC<CR>
endif

"tmux向け設定"
"--------------------------------------------------
" Key Mapping - Toggle
"--------------------------------------------------
nnoremap [toggle] <Nop>
nmap <Leader>c [toggle]
nnoremap <silent> [toggle]s  : setl spell!<CR>          : setl spell?<CR>
nnoremap <silent> [toggle]l  : setl list!<CR>           : setl list?<CR>
nnoremap <silent> [toggle]t  : setl expandtab!<CR>      : setl expandtab?<CR>
nnoremap <silent> [toggle]w  : setl wrap!<CR>           : setl wrap?<CR>
nnoremap <silent> [toggle]cc : setl cursorline!<CR>     : setl cursorline?<CR>
nnoremap <silent> [toggle]cr : setl cursorcolumn!<CR>   : setl cursorcolumn?<CR>
nnoremap <silent> [toggle]n  : setl number!<CR>         : setl number?<CR>
nnoremap <silent> [toggle]r  : setl relativenumber!<CR> : setl relativenumber?<CR>
nnoremap <silent> [toggle]p  : set paste!<CR>
nnoremap <silent> [toggle]v  :<c-u>
            \:if &completeopt =~ 'preview'<CR>
            \:  set completeopt-=preview <CR> :pclose<CR>
            \:else<CR>
            \:  set completeopt+=preview <CR>
            \:endif<CR> :setl completeopt?<CR>

" nnoremap <silent> [toggle]e :if(&colorcolumn > 0)<CR> \: setl colorcolumn=0<CR> 
"                            \: else<CR> : setl colorcolumn=80<CR> : endif<CR>
"--------------------------------------------------
" Key Mapping - Tab page
"--------------------------------------------------
" The prefix key.
nnoremap    [Tab]   <Nop>
nmap    <Leader>t   [Tab]

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
    execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
nnoremap <silent> [Tab]c :tabnew<CR>
nnoremap <silent> [Tab]x :tabclose<CR>
nnoremap <silent> gl :tabnext<CR>
nnoremap <silent> gh :tabprevious<CR>


"--------------------------------------------------
" Key Mapping - abbreviattions
"--------------------------------------------------
let loaded_matchparen = 1 "matchparen pluginをオフ


"自動で括弧内に移動
inoremap {} {}<left>
inoremap () ()<left>
inoremap [] []<left>
inoremap <> <><left>
inoremap '' ''<left>
inoremap `` ``<left>
inoremap "" ""<left>


"For Folding 
inoremap {{{ {{{<CR>}}}
