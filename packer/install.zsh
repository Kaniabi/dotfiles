if [[ ! -d "$HOME/.pkenv/bin" ]]; then
  echo "pkenv: Installing..."
  git clone https://github.com/iamhsa/pkenv.git $HOME/.pkenv
fi
export PATH="$HOME/.pkenv/bin:$PATH"

