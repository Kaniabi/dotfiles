START zoxide 'Improved cd (change directory)'
INSTALL_CMD zoxide https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh
INSTALL_GIT https://github.com/junegunn/fzf.git $HOME/.local/fzf
eval "$(zoxide init zsh)"
ALIAS cd z
