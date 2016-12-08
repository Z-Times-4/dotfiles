rm %HOMEPATH%\.vimrc
mklink %HOMEPATH%\.vimrc %HOMEPATH%\git\dotfiles\.vimrc
rm %HOMEPATH%\.zshrc
mklink %HOMEPATH%\.zshrc %HOMEPATH%\git\dotfiles\.zshrc

mkdir  %HOMEPATH%\.vim\rc\plugins\
mklink %HOMEPATH%\.vim\rc\dein.toml %HOMEPATH%\git\dotfiles\dein.toml
mklink %HOMEPATH%\.vim\rc\dein_lazy.toml %HOMEPATH%\git\dotfiles\dein_lazy.toml
mklink %HOMEPATH%\.vim\rc\plugins\neocomplete.rc.vim %HOMEPATH%\git\dotfiles\neocomplete.rc.vim
mklink %HOMEPATH%\.vim\rc\plugins\neosnippet.rc.vim %HOMEPATH%\git\dotfiles\neosnippet.rc.vim
mklink %HOMEPATH%\.vshim\rc\plugins\unite.rc.vim %HOMEPATH%\git\dotfiles\unite.rc.vim

mkdir %HOMEPATH%\.config\nvim\
mklink %HOMEPATH%\.config\nvim\init.vim %HOMEPATH%\git\dotfiles\.vimrc

mkdir  %HOMEPATH%\.config\nvim\rc\plugins\
mklink %HOMEPATH%\.config\nvim\rc\dein.toml %HOMEPATH%\git\dotfiles\dein.toml
mklink %HOMEPATH%\.config\nvim\rc\dein_lazy.toml %HOMEPATH%~\git\dotfiles\dein_lazy.toml
mklink %HOMEPATH%\.config\nvim\rc\plugins\neocomplete.rc.vim %HOMEPATH%\git\dotfiles\neocomplete.rc.vim
mklink %HOMEPATH%\.config\nvim\rc\plugins\neosnippet.rc.vim %HOMEPATH%\git\dotfiles\neosnippet.rc.vim
mklink %HOMEPATH%\.config\nvim\rc\plugins\unite.rc.vim %HOMEPATH%\git\dotfiles\unite.rc.vim
