#/bin/zsh
#新しい環境に取り込んだ時のインストール

path=`dirname $0`
dir=`readlink -f $path` 

if [ -e /bin/zsh ]; then
	chsh /bin/zsh
fi 

echo "$dir/vimfiles => ~/.vim"
rm ~/.vim
ln -s $dir/vimfiles ~/.vim
mkdir -p  ~/.vim/bundle/

ln -s $dir/.tmux.conf  ~/.tmux.conf

for dotfile in $dir/.* ; do
	dstpath="$HOME/${dotfile##*/}" 

	if [ -e $dstpath ]; then
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
