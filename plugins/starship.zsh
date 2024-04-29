# Command line customization (wip)

if ( $IS_MAC ); then
  INSTALL_CMD starship
else
  if (( ! $+commands[starship] )); then
    wget https://starship.rs/install.sh
    sh ./install.sh -f -b ~/.local/bin
  fi
fi

eval "$(starship init zsh)"
SOURCE $HOME/.dotfiles/key-bindings.zsh

# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# [[ ! -d $ZSH_CUSTOM/plugins/zsh-autocomplete ]] && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
