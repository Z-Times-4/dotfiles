ln -s -f ~/git/dotfiles/.vimrc ~/.vimrc
ln -s -f ~/git/dotfiles/.zshrc ~/.zshrc

mkdir -p  ~/.vim/rc/plugins/
ln -s -f ~/git/dotfiles/dein.toml ~/.vim/rc/dein.toml
ln -s -f ~/git/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -s -f ~/git/dotfiles/neocomplete.rc.vim ~/.vim/rc/plugins/neocomplete.rc.vim
ln -s -f ~/git/dotfiles/neosnippet.rc.vim ~/.vim/rc/plugins/neosnippet.rc.vim
ln -s -f ~/git/dotfiles/unite.rc.vim ~/.vim/rc/plugins/unite.rc.vim
