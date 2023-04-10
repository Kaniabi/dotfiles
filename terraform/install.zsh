export PATH="$HOME/.tfenv/bin:$PATH"

if [[ ! -d "$HOME/.tfenv/bin" ]]; then
  echo "tfenv: Installing..."
  git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
  tfenv install
fi
