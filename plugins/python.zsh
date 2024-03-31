# Python version management

EXPORT PATH "$PATH:$HOME/.pyenv/bin"
if (( ! $+commands[pyenv] )); then
  INSTALL_GIT https://github.com/pyenv/pyenv.git $HOME/.pyenv
  INSTALL_GIT https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
fi
# TEST_CMD pyenv --version
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

TODO Install 'deen' virtualenv if needed.
pyenv shell deen || true
