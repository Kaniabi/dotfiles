# Improved cd (change directory)

INSTALL_GIT https://github.com/junegunn/fzf.git $HOME/.local/fzf
EXPORT PATH "$PATH:$HOME/.local/fzf/bin"
source <(fzf --zsh)

INSTALL_CMD zoxide https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh
eval "$(zoxide init zsh)"
ALIAS cd z

# # Setup
# rm /home/kaniabi/.config/local/share/zoxide/db.zo
# cd Code
# find . -maxdepth 2 -type d | xargs realpath | xargs zoxide add
# cd autosync
# find . -maxdepth 2 -type d | xargs realpath | xargs zoxide add
