# IaC tool.

EXPORT PATH "$PATH:$HOME/.tfenv/bin"
if (( ! $+commands[tfenv] )); then
  INSTALL_GIT https://github.com/tfutils/tfenv.git $HOME/.tfenv
fi
# TEST_CMD tfenv --version
