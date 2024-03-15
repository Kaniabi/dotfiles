if (( ! $+commands[go] ))
then
  echo "go: Installing..."
  sudo apt install -qq -y golang
fi

export PATH=$PATH:$HOME/go/bin
