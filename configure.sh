

#新しい環境に取り込んだ時のインストール
#TODO:ln -s


path=`dirname $0`
dir=`readlink -f $path` 

if [ -e /bin/zsh ]; then
	chsh /bin/zsh
fi 

echo "$path/vimfiles => ~/.vim"
ln -s $path/vimfiles ~/
mv ~/vimfiles ~/.vim
mkdir -p  ~/.vim/bundle/
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim 

for dotfile in $dir/.*rc ; do
	echo $dotfile ⇒  ~/${dotfile##*/}
	ln -s $dotfile ~/${dotfile##*/}
done



