if (( ! $+commands[hub] ))
then
  echo "hub: Installing..."
  sudo add-apt-repository -y ppa:cpick/hub
  sudo apt update -qq
  sudo apt install -qq -y hub
fi
eval "$(hub alias -s zsh)"

