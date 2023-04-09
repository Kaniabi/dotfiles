if [[ ! -d ~/.pyenv ]]; then
  echo "pyenv: Installing..."
  git clone https://github.com/pyenv/pyenv.git             ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git  $(pyenv root)/plugins/pyenv-virtualenv
  pyenv install 3.11.3
  pyenv virtualenv 3.11.3 deen
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
