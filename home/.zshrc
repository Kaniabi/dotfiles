#!/bin/zsh

source $HOME/.dotfiles/dotfiles
EXPORT PATH "$HOME/.local/bin:$PATH"
EXPORT PATH "$HOME/.dotfiles/bin:$PATH"

SOURCE "$HOME/.dotfiles/install"
SOURCE "$HOME/.zshrc.local"

set +e

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
