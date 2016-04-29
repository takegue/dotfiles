#!/usr/bin/env zsh

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

typeset -a lpath
lpath=(
    "$HOME/bin"
    "$HOME/.local/bin"
    /sbin
    /usr/sbin
)

MAILTO='tkngue@example.com'
EMAIL='tkngue@example.com'

if [[ -d ${ANYENV_ROOT:=$HOME/.anyenv} ]]; then
    export PATH="$ANYENV_ROOT/bin:$PATH"
    eval "$(anyenv init -)"
fi

if  (( $+commands[zsh] )) && [ `networksetup -getwebproxy Wi-Fi | grep "^Enabled:" | grep -o "\S\+$"` = "Yes" ]; then
    PROXY=http://`networksetup -getwebproxy Wi-Fi | grep "^Server:.\+$Port" | grep -o "\S\+$"`:`networksetup -getwebproxy Wi-Fi | grep "^Port" | grep -o "\S\+$"`
    export http_proxy=$PROXY
    export https_proxy=$PROXY
    export ftp_proxy=$PROXY
    echo "SET PROXY TO \"${PROXY}\" " 2> /dev/stderr
else
    PROXY=""
    export http_proxy=$PROXY
    export https_proxy=$PROXY
    export ftp_proxy=$PROXY
    echo "SET PROXY TO NO PROXY " 2> /dev/stderr
fi 


#  vim:ft=zsh
