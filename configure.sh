

#新しい環境に取り込んだ時のインストール
#TODO:ln -s


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



