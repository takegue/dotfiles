#/bin/zsh

#新しい環境に取り込んだ時のインストール


path=`dirname $0`
dir=`readlink -f $path` 

if [ -e /bin/zsh ]; then
	chsh /bin/zsh
fi 

ln -s $path/vimfiles ~/.vim
for dotfile in $dir/.*rc ; do
	echo $dotfile ⇒  ~/${dotfile##*/}
	ln -s $dotfile ~/${dotfile##*/}
done

mkdir -p ~/.vim/bundle
if [ ! -e ./.vim/bundle/neobundle.vim ] ; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
