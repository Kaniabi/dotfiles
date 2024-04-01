# Command line customization (wip)

TODO "Install starship"
# if ( $IS_MAC ); then
#   INSTALL_CMD starship
# fi

INSTALL_CMD snapd snap
if (( ! $+commands[snap] )); then
  sudo snap install core
fi

if (( ! $+commands[starship] )); then
  sudo snap install starship --edge
fi

eval "$(starship init zsh)"
SOURCE $HOME/.dotfiles/key-bindings.zsh

# WIP: Replacing oh-my-zsh with starship.
# START oh-my-zsh 'Zsh extensions'
# EXPORT ZSH_THEME "kaniabi-mortalscumbag"
# EXPORT ZSH_CUSTOM $HOME/.dotfiles/oh-my-zsh
# EXPORT ZSH_DISABLE_COMPFIX true
# EXPORT ZSH $HOME/.oh-my-zsh
# INSTALL_GIT https://github.com/robbyrussell/oh-my-zsh.git $ZSH
# SOURCE "$ZSH/oh-my-zsh.sh"

# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# [[ ! -d $ZSH_CUSTOM/plugins/zsh-autocomplete ]] && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
