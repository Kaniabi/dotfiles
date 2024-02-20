#============================================================================== zoxide
export PATH=$PATH:$HOME/.local/bin

if (( ! $+commands[zoxide] ))
then
  echo "*** Installing zoxide"
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

eval "$(zoxide init zsh)"

alias cd=z

#============================================================================== fzf
export PATH=$PATH:$HOME/.local/fzf/bin

if (( ! $+commands[fzf] ))
then
  echo "*** Installing fzf"
   git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.local/fzf
fi

eval "$(zoxide init zsh)"

alias cd=z
