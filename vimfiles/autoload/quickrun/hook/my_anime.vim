scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


function! quickrun#hook#my_anime#new()
    return shabadou#make_quickrun_hook_anim(
                \	"my_anime",
                \[
                \       '|',
                \       '/',
                \       '-',
                \       '\',
                \]
                \,      1
                \)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
