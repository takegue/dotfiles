#!/usr/bin/env sh
#新しい環境に取り込んだ時のインストール

path=`dirname $0`
dir=`readlink -f $path` 

if [ -e /usr/bin/zsh ]; then
	chsh /usr/bin/zsh
fi 

echo "$dir/vimfiles => ~/.vim"
rm ~/.vim ~/.vimrc.min ~/.git_template
ln -s $dir/vimfiles ~/.vim
ln -s $dir/.git_template ~/.git_template
ln -s $dir/.vimrc.min ~/.vimrc.min

mkdir -p  ~/.vim/bundle/

for dotfile in $dir/.*rc $dir/.*.conf $dir/.ctags $dir/.pythonstartup; do
    dstpath="$HOME/${dotfile##*/}" 
    if [ -L $dstpath ]; then
        rm $dstpath
        echo "remove $dstpath"
    fi 
    echo "$dotfile => $dstpath" 
    ln -s $dotfile ~/ 
done

mkdir -p ~/.vim/bundle
if [ ! -e ./.vim/bundle/neobundle.vim ] ; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

git config --global init.template ~/.git_template
git config --global user.name  'TKNGUE'
git config --global user.email `echo 'takenoatjnlp.org' | sed 's/at/@/g'`
