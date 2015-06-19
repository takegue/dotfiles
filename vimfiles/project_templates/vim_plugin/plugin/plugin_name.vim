" ========================================
" Author: author_name <mail>
" Contributers:
" License: 
" Version:
" ========================================
"
if exists('g:loaded_<+PLUGIN_NAME+>')
    finish
endif

let g:loaded_<+PLUGIN_NAME+> = 1


let s:save_cpo = &cpo
set cpo&vim



let &cpo = s:save_cpo
unlet s:save_cpo
