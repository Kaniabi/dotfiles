#!/bin/zsh

source $HOME/.dotfiles/dotfiles
SOURCE $HOME/.dotfiles/install
SOURCE "$HOME/.zshrc.local"

EXPORT PATH "$DOTFILES/bin:$PATH"

set +e