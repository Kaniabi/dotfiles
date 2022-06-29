if [[ ! -d "$HOME/.tfenv/bin" ]]; then
  echo "tfenv: Installing..."
  git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
fi
export PATH="$HOME/.tfenv/bin:$PATH"