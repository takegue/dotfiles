#!/usr/bin/env zsh
#
export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

MAILTO='tkngue@example.com'


PROXY="http://proxy.nagaokaut.ac.jp:8080"

export http_proxy=$PROXY
export https_proxy=$PROXY
export ftp_proxy=$PROXY
export HTTP_PROXY=$PROXY
export HTTPS_PROXY=$PROXY
export FTP_PROXY=$PROXY

# export http_proxy=''
# export https_proxy=''
# export ftp_proxy=''
# export HTTP_PROXY=''
# export HTTPS_PROXY=''
# export FTP_PROXY=''

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
