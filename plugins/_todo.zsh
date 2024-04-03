# TODO: How to install newer version on Debian12?
# apt_install python3-launchpadlib software-properties-common
# sudo add-apt-repository ppa:neovim-ppa/stable -y

# # Plugin manager for zsh (disabled until decide what to do with spaceship and oh-my-zsh)
# export ZPLUG_HOME=$HOME/.local/zplug
# git_install https://github.com/zplug/zplug $ZPLUG_HOME
# SOURCE $ZPLUG_HOME/init.zsh

START private.env 'Private environment variables from 1Password'
set -a
SOURCE /tmp/.private.env
set +a
