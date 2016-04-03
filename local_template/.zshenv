#!/usr/bin/env zsh

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

typeset -a lpath
lpath=(
    $HOME/.pyenv/bin
    # $HOME/.rbenv/bin
    "$HOME/bin"
    "$HOME/.local/bin"
    /sbin
    /usr/sbin
)
 

MAILTO='tkngue@example.com'

if [ -x `which networksetup` ] && [ `networksetup -getwebproxy Wi-Fi | grep "^Enabled:" | grep -o "\S\+$"` = "Yes" ]; then
    PROXY=http://`networksetup -getwebproxy Wi-Fi | grep "^Server:.\+$Port" | grep -o "\S\+$"`:`networksetup -getwebproxy Wi-Fi | grep "^Port" | grep -o "\S\+$"`
    export http_proxy=$PROXY
    export https_proxy=$PROXY
    export ftp_proxy=$PROXY
    echo "SET PROXY TO \"${PROXY}\" "
else
    PROXY=""
    export http_proxy=$PROXY
    export https_proxy=$PROXY
    export ftp_proxy=$PROXY
    echo "SET PROXY TO NO PROXY "
fi 

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
