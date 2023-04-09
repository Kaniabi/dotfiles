function apt_install () {
  local PACKAGE=$1
  sudo apt install -y $PACKAGE
}

function apt_install_cmd () {
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    apt_install $PACKAGE
  fi
}

function url_install_cmd () {
  local CMD=$1
  local URL=$2
  if (( ! $+commands[$CMD] ))
  then
    curl -o- $URL | bash
  fi
}

function source_it () {
  if [[ ! -f $1 ]]; then
    return
  fi
  echo "$1"
  source $1
}

function die () {
  echo $1
  exit 99
}
