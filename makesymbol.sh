ln -s -f ~/git/dotfiles/.vimrc ~/.vimrc
ln -s -f ~/git/dotfiles/.zshrc ~/.zshrc

mkdir -p  ~/.vim/rc/plugins/
ln -s -f ~/git/dotfiles/dein.toml ~/.vim/rc/dein.toml
ln -s -f ~/git/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -s -f ~/git/dotfiles/neocomplete.rc.vim ~/.vim/rc/plugins/neocomplete.rc.vim
ln -s -f ~/git/dotfiles/neosnippet.rc.vim ~/.vim/rc/plugins/neosnippet.rc.vim
ln -s -f ~/git/dotfiles/unite.rc.vim ~/.vim/rc/plugins/unite.rc.vim

mkdir -p ~/.config/nvim/
ln -s -f ~/git/dotfiles/.vimrc ~/.config/nvim/init.vim

mkdir -p  ~/.config/nvim/rc/plugins/
ln -s -f ~/git/dotfiles/dein.toml ~/.config/nvim/rc/dein.toml
ln -s -f ~/git/dotfiles/dein_lazy.toml ~/.config/nvim/rc/dein_lazy.toml
ln -s -f ~/git/dotfiles/neocomplete.rc.vim ~/.config/nvim/rc/plugins/neocomplete.rc.vim
ln -s -f ~/git/dotfiles/neosnippet.rc.vim ~/.config/nvim/rc/plugins/neosnippet.rc.vim
ln -s -f ~/git/dotfiles/unite.rc.vim ~/.config/nvim/rc/plugins/unite.rc.vim
