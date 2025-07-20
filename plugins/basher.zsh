# Packager manager for Bash scripts

PATH="$HOME/.basher/bin:$PATH"
INSTALL_CMD basher https://raw.githubusercontent.com/basherpm/basher/master/install.sh
eval "$(basher init - zsh)"
