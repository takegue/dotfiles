"--------------------------------------------------
" Colorscheme
"------------------------------------------------- 
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme' 
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'altercation/vim-colors-solarized'

set t_Co=256
if $COLORTERM == 'gnome-terminal'
    let g:solarized_termcolors=256
    if has('gui_running')
        set background=light
    else
        set background=dark
    endif
endif
