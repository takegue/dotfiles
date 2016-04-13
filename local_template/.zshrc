#!/usr/bin/env zsh

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

typeset -a lpath
lpath=(
    $HOME/.pyenv/bin
    $HOME/.rbenv/bin
)

MAILTO='tkngue@example.com'

if [[ -n $TMUX ]]; then
    export PYENV_ROOT=$HOME/.pyenv
    export RBENV_ROOT=$HOME/.rbenv/
    export PATH=$PYENV_ROOT/bin:$PATH
    export PATH=$RBENV_ROOT/bin:$PATH

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    eval "$(rbenv init -)"
fi

#  vim:ft=zsh
