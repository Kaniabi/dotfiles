
# Utility functions

function rmpyc () {
  find . -name "*.pyc" -delete
}

# Installs pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
