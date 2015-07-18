#!/usr/bin/env bash

if [[ ! -e `which hg` ]]; then
    echo 'not found mercurial'
    exit 1;
fi 

DIST_VIM=/tmp/vim

if [[ ! -d $DIST_VIM ]]; then
    hg clone https://vim.googlecode.com/hg $DIST_VIM
else [[ -d $DIST_VIM ]];
    hg pull -u -R $DIST_VIM 
fi

cd $DIST_VIM

echo 'exit code is' $?
if [[ $? -eq 0 ]]; then
    echo 'No update'
    exit 0;

fi

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

make && sudo make install

