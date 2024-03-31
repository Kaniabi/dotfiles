# Image builder

EXPORT PATH "$PATH:$HOME/.pkenv/bin"
if (( ! $+commands[pkenv] )); then
  INSTALL_GIT https://github.com/iamhsa/pkenv.git $HOME/.pkenv
fi
# TEST_CMD pkenv --version
