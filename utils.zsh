function apt_install () {
  local PACKAGE=$1
  sudo apt install -y $PACKAGE
}

function apt_install_cmd () {
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    echo "*** apt_install_cmd $@"
    apt_install $PACKAGE
  fi
}

function go_install_cmd () {
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    echo "*** go_install_cmd $@"
    go install $PACKAGE
  fi
}

function url_install_cmd () {
  local CMD=$1
  local URL=$2
  if (( ! $+commands[$CMD] ))
  then
    echo "*** url_install_cmd $@"
    curl -s -o- $URL | bash
  fi
}

function git_install () {
  local REPO_URL=$1
  local LOCAL_DIR=$2
  if [ ! -d $LOCAL_DIR ]
  then
    echo "*** git_install $@"
    git clone --quiet "$REPO_URL" "$LOCAL_DIR"
  fi
}

function source_it () {
  if [[ ! -f $1 ]]; then
    return
  fi
  echo "*** source_it $@"
  source $1
}

function die () {
  echo $1
  exit 99
}

INSTALL_DIR=""
function START () {
  FINISH
  INSTALL_DIR="/tmp/$1"
  echo "#============================================================================== $1"
  mkdir -p $INSTALL_DIR
  cd $INSTALL_DIR
}

function FINISH () {
  if [[ -n $INSTALL_DIR ]]; then
    sudo rm -rf $INSTALL_DIR
    cd $HOME
    INSTALL_DIR=""
  fi
}

function DOWNLOAD () {
  if [[ "$1" = "s3://"* ]]; then
    AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS%,*} AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS#*,} aws s3 cp $1 ${1##*/}
  else
    wget --no-verbose "$@"
  fi
}

function INSTALL () {
  local PACKAGE=$1;
  if [[ $PACKAGE = *".deb" ]]; then
    shift
    if [[ $PACKAGE == @("http:"*|"https:"*|"s3://"*) ]]; then
      DOWNLOAD $PACKAGE
      PACKAGE=$(basename $PACKAGE)
    fi
    sudo dpkg -i $PACKAGE $@
  else
    sudo apt-get install --no-install-recommends -y $@
  fi
}

function INSTALL_CMD () {
  local CMD=$1
  local PACKAGE=${2:-$1}
  if (( ! $+commands[$CMD] ))
  then
    echo "*** install_cmd $@"
    INSTALL $PACKAGE
  fi
}
