#!/bin/zsh

DOTFILES_DEBUG=true

function INFO () {
  [[ $DOTFILES_DEBUG ]] && echo "*** $@"
}

# MACHINE
case "$(uname -s)" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    MSYS_NT*)   MACHINE=Git;;
    *)          MACHINE="UNKNOWN:${unameOut}"
esac

function go_install_cmd () {
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    INFO "go_install_cmd $@"
    go install $PACKAGE
  fi
}

function url_install_cmd () {
  local CMD=$1
  local URL=$2
  if (( ! $+commands[$CMD] ))
  then
    INFO "url_install_cmd $@"
    curl -s -o- $URL | bash
  fi
}

function git_install () {
  local REPO_URL=$1
  local LOCAL_DIR=$2
  if [ ! -d $LOCAL_DIR ]
  then
    INFO "git_install $@"
    git clone --quiet "$REPO_URL" "$LOCAL_DIR"
  fi
}

function SOURCE () {
  if [[ ! -f $1 ]]; then
    return
  fi
  INFO "SOURCE $1"
  source $1
}

function die () {
  echo $1
  exit 99
}

INSTALL_DIR=""
function START () {
  FINISH
  INSTALL_DIR="/tmp/$1"
  echo "#============================================================================== $1"
  mkdir -p $INSTALL_DIR
  cd $INSTALL_DIR
}

function FINISH () {
  if [[ -n $INSTALL_DIR ]]; then
    sudo rm -rf $INSTALL_DIR
    cd $HOME
    INSTALL_DIR=""
  fi
}

function DOWNLOAD () {
  if [[ "$1" = "s3://"* ]]; then
    AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS%,*} AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS#*,} aws s3 cp $1 ${1##*/}
  else
    INFO "DOWNLOAD $@"
    wget --no-verbose "$@"
  fi
}

function INSTALL () {
  local PACKAGE=$1;
  INFO "INSTALL $@"
  if [[ $MACHINE == "Mac" ]]; then
    brew install -q $PACKAGE
  elif [[ $PACKAGE = *".deb" ]]; then
    shift
    if [[ $PACKAGE == @("http:"*|"https:"*|"s3://"*) ]]; then
      DOWNLOAD $PACKAGE
      PACKAGE=$(basename $PACKAGE)
    fi
    sudo dpkg -i $PACKAGE $@
  else
    sudo apt-get install --no-install-recommends -y $@
  fi
}

function INSTALL_CMD () {
  INFO "INSTALL_CMD $@"
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    INSTALL $PACKAGE
  fi
}

function ALIAS () {
  INFO "ALIAS $1"
  alias $1=$2
}

function EXPORT () {
  INFO "EXPORT $1"
  export $1=$2
}

#=========================================================================


# NeoVim
# apt_install python3-launchpadlib software-properties-common
# sudo add-apt-repository ppa:neovim-ppa/stable -y

if [[ $MACHINE != "Mac" ]]; then
  INSTALL_CMD nala
  ALIAS apt "sudo nala"
fi

if [[ $MACHINE == "Mac" ]]; then
  INSTALL_CMD bat
else
  INSTALL_CMD batcat bat
fi

INSTALL_CMD jq

INSTALL_CMD go golang

INSTALL_CMD parallel

INSTALL_CMD ag silversearcher-ag
ALIAS ag "\ag --hidden"

INSTALL_CMD unzip

INSTALL_CMD wget

INSTALL_CMD starship

INSTALL_CMD eza
ALIAS dir "eza -la"

# NOTE: Debian12 have a pretty old neovim.
INSTALL_CMD nvim neovim
ALIAS vim "nvim"
EXPORT EDITOR "nvim"

# # Plugin manager for zsh (disabled until decide what to do with spaceship and oh-my-zsh)
# export ZPLUG_HOME=$HOME/.local/zplug
# git_install https://github.com/zplug/zplug $ZPLUG_HOME
# SOURCE $ZPLUG_HOME/init.zsh

# TODO: This is failing on Debian12 (remote-machine).
#if (( ! $+commands[locale-gen] ))
#then
#  sudo apt install locales
#  sudo locale-gen en_US.UTF-8
##  echo "LANGUAGE=en_US.UTF-8
##LC_ALL=en_US.UTF-8
##LANGUAGE=en_US.UTF-8" | sudo tee /etc/default/locale
#  echo "locales locales/default_environment_locale select en_US.UTF-8" | sudo debconf-set-selections
#  echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | sudo debconf-set-selections
#  sudo dpkg-reconfigure --frontend noninteractive locales
#fi

function DOTFILES_SYMLINK () {
  echo "*** DOTFILES_SYMLINK $1"
  ln -s $HOME/projects/dotfiles/$1 $HOME/$1
}

DOTFILES_SYMLINK .zshrc
DOTFILES_SYMLINK .gitconfig.local
DOTFILES_SYMLINK .gitconfig
# SYMLINK .gitignore

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
[[ -a ~/.localrc ]] && source ~/.localrc

SOURCE "$ZSH/oh-my-zsh.sh"
SOURCE "$HOME/.zshrc.local"
# TODO: Re-enable this
# SOURCE "$HOME/projects/private/private.env"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DOTFILES=$HOME/.dotfiles
export PROJECTS=$HOME/projects

# export ZSH_THEME="kaniabi-mortalscumbag"
# export ZSH_CUSTOM=$DOTFILES/oh-my-zsh
# export ZSH_DISABLE_COMPFIX=true
# export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"
