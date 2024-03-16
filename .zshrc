$HOME/.dotfiles/install

source $HOME/.dotfiles/dotfiles

DOTFILES_SYMLINK .zshrc
DOTFILES_SYMLINK .zshrc.local
DOTFILES_SYMLINK .gitconfig.local
DOTFILES_SYMLINK .gitconfig

SOURCE "$HOME/.zshrc.local"

EXPORT PATH "$DOTFILES/bin:$PATH"
