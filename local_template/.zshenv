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

# For memo tools
JUNK=/tmp

if [[ -d ${ANYENV_ROOT:=$HOME/.anyenv} ]]; then
    lpath=( $ANYENV_ROOT/bin $lpath )
    eval "$( $ANYENV_ROOT/bin/anyenv init -)"
    for D in ${(s/:/z)PATH}
    do
        [[ $D =~ $ANYENV_ROOT ]] && echo $D && lpath=( $D $lpath )
    done
fi

#  vim:ft=zsh
