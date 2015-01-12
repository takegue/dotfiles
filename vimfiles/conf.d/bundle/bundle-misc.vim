"--------------------------------------------------
" Other 
"------------------------------------------------- 
NeoBundle 'vim-jp/vimdoc-ja'        " ヘルプの日本語化
NeoBundle 'mattn/learn-vimscript'   " help for vim script
NeoBundle 'Shougo/neobundle-vim-recipes'
NeoBundle 'vim-jp/vital.vim'
'


NeoBundle 'uguu-org/vim-matrix-screensaver'

NeoBundleLazy 'tsukkee/lingr-vim', {
            \ 'autoload' : {
            \   'commands' : ['Lingr']
            \}}
nnoremap <silent> <Leader>lg :<C-u>LingrLaunch<CR>
let s:hooks = neobundle#get_hooks('lingr-vim')
function! s:hooks.on_source(bundle)
    let g:lingr_vim_user = 'mnct.tkn3011@gmail.com'
    let g:lingr_vim_sidebar_width = 25 
    let g:lingr_vim_rooms_buffer_height = 10
    let g:lingr_vim_say_buffer_height = 3
    let g:lingr_vim_remain_height_to_auto_scroll = 5
    let g:lingr_vim_time_format     = '%c'
    let g:lingr_vim_command_to_open_url = 'firefox %s'

    function! s:notify(title, message)
        if has('unix')
            let notify_cmd = 'notify_send %s %s'
        elseif has('windows')
            let notify_cmd = 'notify_send %s %s'
        elseif has('mac')
            let notify_cmd = 'growlnotify -t %s -m %s'
        else
        endif
        execute printf('silent !'. notify_cmd, shellescape(a:title, 1), shellescape(a:message, 1))
    endfunction

    augroup lingr-vim
        autocmd!
        " autocmd User WinEnter
        autocmd User plugin-lingr-message
        \   let s:temp = lingr#get_last_message()
        \|  if !empty(s:temp)
        \|      call s:notify(s:temp.nickname, s:temp.text)
        \|  endif
        \|  unlet s:temp

        autocmd User plugin-lingr-presence
        \   let s:temp = lingr#get_last_member()
        \|  if !empty(s:temp)
        \|      call s:notify(s:temp.name, (s:temp.presence ? 'online' : 'offline'))
        \|  endif
        \|  unlet s:temp
    augroup END

endfunction
unlet s:hooks


NeoBundle 'TKNGUE/atcoder_helper', {'type__protocol' : 'ssh' }
if neobundle#tap('atcoder_helper')
    let g:online_jadge_path = '/home/takeno/.local/src/OnlineJudgeHelper/oj.py'
    let g:atcoder_config = '/home/takeno/.local/src/OnlineJudgeHelper/setting.json'
    let g:atcoder_dir = '$HOME/Documents/codes/atcoder'
    function! neobundle#hooks.on_source(bundle)
    endfunction
    call neobundle#untap()
endif


NeoBundle 'TKNGUE/sum-it.vim', {}
if neobundle#tap('sum-it.vim')
    function! neobundle#hooks.on_source(bundle)
    endfunction
    call neobundle#untap()
endif


