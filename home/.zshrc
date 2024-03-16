#!/bin/zsh

source $HOME/.dotfiles/dotfiles
EXPORT PATH "$HOME/.local/bin:$PATH"
EXPORT PATH "$HOME/.dotfiles/bin:$PATH"

SOURCE $HOME/.dotfiles/install
SOURCE "$HOME/.zshrc.local"

set +e
