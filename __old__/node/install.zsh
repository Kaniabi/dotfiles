if (( ! $+commands[npm] ))
then
  apt_install_cmd node nodejs npm
fi

apt_install_cmd yarn
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


