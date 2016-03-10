export WORKON_HOME=$HOME/VirtualEnvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

export GIT_EDITOR=vim
# We are using fleet now, so DOCKER_HOST no longer works ... keeping for future reference.
#export DOCKER_HOST=tcp://54.207.132.204:2375
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FLEETCTL_TUNNEL=54.232.124.153:22
