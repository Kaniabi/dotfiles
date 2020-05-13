#!/bin/bash

set -ex

_INSTALL_DRIVE=d
_INSTALL_NAME=Eoan
_USERNAME=kaniabi
_FILENAME=eoan-server-cloudimg-amd64-wsl.rootfs.tar.gz
_PYTHON_VERSION=3.8.1
_HUB_VERSION=2.14.1
_HUB_PACKAGE=hub-linux-amd64-$_HUB_VERSION.tgz

_setup_wsl () {
  if [[ ! -f $_FILENAME ]]; then
    wget https://cloud-images.ubuntu.com/eoan/current/$_FILENAME
  fi
  if [[ -d /$_INSTALL_DRIVE/$_INSTALL_NAME ]]; then
    wsl.exe --terminate $_INSTALL_NAME || true
    wsl.exe --unregister $_INSTALL_NAME || true
    rm -rf /$_INSTALL_DRIVE/$_INSTALL_NAME
  fi

  wsl.exe --import $_INSTALL_NAME "$_INSTALL_DRIVE:\\$_INSTALL_NAME" $_FILENAME
}

_configure_system () {
  # Update system
  # *****************************************************************************
  apt update
  apt upgrade -y
  apt install -y zsh docker.io python3-pip
  # * Python requirements
  apt install -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    wget \
    silversearcher-ag


  # Fix WSL mount directory.
  # *****************************************************************************
  echo "[automount]
enabled = true
root = /
options = \"metadata,umask=022,fmask=113\"
mountFsTab = false

[network]
generateHosts = true
generateResolvConf = true
" > /etc/wsl.conf

  # Create user
  # ***************************************************************************
  deluser $_USERNAME || true
  delgroup $_USERNAME || true
  rm -rf /home/$_USERNAME || true
  adduser $_USERNAME --uid 1000 --shell=/bin/zsh --disabled-password --gecos ""
  echo -e "chucknorris\nchucknorris" | passwd $_USERNAME
  usermod -G sudo kaniabi

  sudo -u kaniabi -s bash -c "ssh-keygen -N '' -f /home/$_USERNAME/.ssh/id_rsa"
  cat /home/$_USERNAME/.ssh/id_rsa.pub

  # TODO: User with sudo without password

  # Install hub
  # ***************************************************************************
  if [[ ! -f $_HUB_PACKAGE ]]; then
    wget https://github.com/github/hub/releases/download/v$_HUB_VERSION/$_HUB_PACKAGE
  fi
  tar -xzf $_HUB_PACKAGE
  ./hub-linux-amd64-$_HUB_VERSION/install

  # Configure user
  # ***************************************************************************
  sudo -u kaniabi /mnt/$_INSTALL_DRIVE/Projects/dotfiles/_setup/setup.sh configure-user

}

_configure_user () {
  # Projects directory
  ln -s /d/Projects /home/$_USERNAME/projects

  # Install dotfiles + oh-my-zsh
  ln -s ~/projects/dotfiles /home/$_USERNAME/.dotfiles
  git clone https://github.com/ohmyzsh/ohmyzsh.git /home/$_USERNAME/.oh-my-zsh

  # Install PyEnv
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

  # Install Python
  ~/.pyenv/bin/pyenv install $_PYTHON_VERSION
  ~/.pyenv/bin/pyenv virtualenv $_PYTHON_VERSION deen

  # Instal dotfiles
  ~/projects/dotfiles/script/bootstrap
}


case $1 in
  install):
    _setup_wsl
    wsl.exe -d $_INSTALL_NAME -- bash -c "/mnt/$_INSTALL_DRIVE/Projects/dotfiles/_setup/setup.sh configure-system"
    ;;
  setup-wsl)
    _setup_wsl
    ;;
  configure-system)
    _configure_system
    ;;
  configure-user)
    _configure_user
    ;;
  *)
    echo "
    Usage:
      setup.sh <CMD>
        install
        setup-wsl
        configure-system
        configure-user
    "
esac
