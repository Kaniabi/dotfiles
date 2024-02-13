if (( ! $+commands[hub] ))
then
  echo "hub: Installing..."
  sudo apt update -qq
  sudo apt install -qq -y hub
fi
eval "$(hub alias -s zsh)"

