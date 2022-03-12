if [[ ! -d ~/.pyenv ]]; then
  echo "pyenv: Installing..."
  git clone https://github.com/tfutils/tfenv.git ~/.tfenv
fi

function rmpyc () {
  find . -name "*.pyc" -delete
}

# Installs pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export VIRTUAL_ENV_DISABLE_PROMPT=1

pyenv shell deen
