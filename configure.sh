#!/bin/zsh
path=`dirname $0`
dir=`readlink -f $path` 

if [ -e /bin/zsh ]; then
	chsh /bin/zsh
fi 

echo "$dir/vimfiles => ~/.vim"
ln -s $dir/vimfiles ~/.vim
mkdir -p  ~/.vim/bundle/
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim 

ln -s $dir/.tmux.conf  ~/.tmux.conf

for dotfile in $dir/.*rc ; do
	dstpath="$HOME/${dotfile##*/}" 

	if [ -e "${dstpath}" ]; then
		rm $dstpath
		echo "remove $dstpath"
	fi 
	
	echo "$dotfile => $dstpath" 
	ln -s $dotfile ~/ 
done



