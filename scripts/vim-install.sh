#!/bin/env sh


if [ -e `which hg` ]; then
    echo 'not found mercurial'
    exit 1;
fi 
hg clone https://vim.googlecode.com/hg /tmp/vim

cd /tmp/vim

./configure \
    --prefix=~/.local \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --enable-luainterp \
    --with-features=huge \
    --disable-selinux \
    --enable-luainterp=yes \
    --with-lua-prefix=/usr/local/bin \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \

make && make install

