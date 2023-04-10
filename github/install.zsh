if (( ! $+commands[gh] ))
then
  echo "gh: Installing..."
#  sudo add-apt-repository -y ppa:cpick/hub
#  sudo apt update -qq
  sudo apt install -qq -y gh
fi
# eval "$(hub alias -s zsh)"

