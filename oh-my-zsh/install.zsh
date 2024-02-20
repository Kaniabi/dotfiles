if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "oh-my-zsh: Installing..."
  git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

  # This is another way of installing oh-my-zsh
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

fi

# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# [[ ! -d $ZSH_CUSTOM/plugins/zsh-autocomplete ]] && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
