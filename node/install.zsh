if (( ! $+commands[npm] ))
then
  apt_install_cmd node nodejs npm
fi

if (( ! $+commands[jq] ))
then
  sudo npm install -g jq
fi

