START jq 'JSON query tool'
INSTALL_CMD jq

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

START aws 'AWS CLI and friends'
if ( $IS_MAC ); then
  INSTALL_CMD aws awscli
else
  INSTALL_CMD aws "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  INSTALL_CMD session-manager-plugin "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
  INSTALL_CMD sam "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
  INSTALL_CMD ecs-cli "https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest"
fi

if ( $IS_WSL ); then
  START wslu 'Utilities for Windows WSL'

  # INSTALL wslu
  # sudo apt install gnupg2 apt-transport-https
  # wget -O - https://pkg.wslutiliti.es/public.key | sudo gpg -o /usr/share/keyrings/wslu-archive-keyring.pgp --dearmor
  # echo "deb [signed-by=/usr/share/keyrings/wslu-archive-keyring.pgp] https://pkg.wslutiliti.es/debian bookworm main" | sudo tee -a /etc/apt/sources.list.d/wslu.list
  # sudo apt update
  # sudo apt install wslu
fi
