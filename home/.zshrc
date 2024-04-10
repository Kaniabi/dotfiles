#!/bin/zsh

source $HOME/.dotfiles/dotfiles
EXPORT PATH "$HOME/.local/bin:$PATH"
EXPORT PATH "$HOME/.dotfiles/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$HOME/.zsh_history" # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# dirs
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'

# Key bindings (from oh-my-zsh)
SOURCE $HOME/.dotfiles/key-bindings.zsh

# ---

SOURCE "$HOME/.dotfiles/install"

# # Load Git completion
# source /usr/share/bash-completion/completions/git
# zstyle ':completion:*:*:git:*' script $DITFILES/gitfast/git-completion.bash
fpath=(~/.dotfiles/completion $fpath)
autoload -Uz compinit && compinit
