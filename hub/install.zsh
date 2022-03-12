if (( ! $+commands[hub] ))
then
  echo "hub: Installing..."
  sudo add-apt-repository -y ppa:cpick/hub
  sudo apt update
  sudo apt install -y -qq hub
fi

eval "$(hub alias -s)"

