if [[ $(uname) != "Darwin" ]]; then
  apt_install_cmd parallel
  apt_install_cmd ag silversearcher-ag
fi