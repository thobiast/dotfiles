# dotfiles

My config files.

## Install

```console
# Keep default .bashrc. Just add customized bashrc
echo 'test -f ~/dotfiles/.bashrc && source $_' >> ~/.bashrc

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.screenrc ~/.screenrc
ln -s ~/dotfiles/.ctags ~/.ctags
ln -s ~/dotfiles/.gitbash ~/.gitbash
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.inputrc ~/.inputrc
```

