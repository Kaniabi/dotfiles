# NeoVim command line file editor.

# NOTE: Debian12 have a pretty old neovim.
START neovim 'Text editor'
INSTALL_CMD nvim neovim
ALIAS vim "nvim"
EXPORT EDITOR "nvim"

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
