" Key Mapping
"-------------------------------------------------- 
"<Leader>を,に変更
let mapleader=','

"素早くjj と押すことでESCとみなす
" inoremap jj <Esc>
" nnoremap ; q:a
" nnoremap ; :
" nnoremap : ;
"
nnoremap & g&

" ESCを二回押すことでハイライトを消す
nnoremap <silent> <Esc><Esc>    :noh<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

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
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent><C-F> :<C-U>setl lazyredraw<CR><C-D><C-D>:setl nolazyredraw<CR>
nnoremap <silent><C-B> :<C-U>setl lazyredraw<CR><C-U><C-U>:setl nolazyredraw<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+


"tmux向け設定"

"--------------------------------------------------
" Key Mapping - Toggle
"--------------------------------------------------
nnoremap [toggle] <Nop>
nmap <Leader>c [toggle]
nnoremap <silent> [toggle]s : setl spell!<CR>          : setl spell?<CR>
nnoremap <silent> [toggle]l : setl list!<CR>           : setl list?<CR>
nnoremap <silent> [toggle]t : setl expandtab!<CR>      : setl expandtab?<CR>
nnoremap <silent> [toggle]w : setl wrap!<CR>           : setl wrap?<CR>
nnoremap <silent> [toggle]c : setl cursorline!<CR>     : setl cursorline?<CR>
nnoremap <silent> [toggle]n : setl number!<CR>         : setl number?<CR>
nnoremap <silent> [toggle]r : setl relativenumber!<CR> : setl relativenumber?<CR>
nnoremap <silent> [toggle]p : set paste!<CR> 
" nnoremap <silent> [toggle]e :if(&colorcolumn > 0)<CR> \: setl colorcolumn=0<CR> 
"                            \: else<CR> : setl colorcolumn=80<CR> : endif<CR>


"--------------------------------------------------
" Key Mapping - Tab page
"--------------------------------------------------
function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    <Leader>t   [Tag]

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
nnoremap <silent> [Tag]c :tabnew<CR>
nnoremap <silent> [Tag]x :tabclose<CR>
nnoremap <silent> [Tag]n :tabnext<CR>
nnoremap <silent> [Tag]p :tabprevious<CR>

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


"自動で---, ===を変換"
iab ---- --------------------------------------------------<CR>
iab ==== ==================================================<CR>
iab ++++ ++++++++++++++++++++++++++++++++++++++++++++++++++<CR>
iab ____ __________________________________________________<CR>
iab //// //////////////////////////////////////////////////<CR>

