#!/usr/bin/env bash

if [[ ! -e `which git` ]]; then
    echo 'not found git'
    exit 1;
fi 

DIST_VIM=/tmp/vim

if [[ ! -d $DIST_VIM ]]; then
    # hg clone https://vim.googlecode.com/hg $DIST_VIM
    git clone https://github.com/vim/vim.git $DIST_VIM
else [[ -d $DIST_VIM ]];
    git -C $PATH pull origin master 
fi

cd $DIST_VIM

./configure \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --with-features=huge \
    --with-luajit \
    --disable-selinux \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \

make && sudo make install

