export PATH="$HOME/.pyenv/bin:$PATH"

if [[ ! -d ~/.pyenv ]]; then
  echo "pyenv: Installing..."
  git clone https://github.com/pyenv/pyenv.git             ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git  $(pyenv root)/plugins/pyenv-virtualenv
fi

function rmpyc () {
  find . -name "*.pyc" -delete
}

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export VIRTUAL_ENV_DISABLE_PROMPT=1

pyenv shell deen | true
