# System basic commands

INSTALL_CMD unzip
INSTALL_CMD jq
INSTALL_CMD realpath coreutils
INSTALL_CMD ts moreutils # ts, parallel, chronic
INSTALL_CMD multitail
INSTALL_CMD envsubst gettext-base

if ( ! $IS_MAC ); then
  function grealpath { realpath "$@" }
fi

function ffind () {
  echo "find . -name '*$1*'"
  find . -name "*$1*"
}

function genpasswd () {
  PASSWORD_LEVEL=4
  RESULT=""
  for ((i=1;i<=PASSWORD_LEVEL;i++)); do
    PASSWORD_PART="$(strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 4 | tr -d '\n')"
    if [[ $PASSWORD_PART =~ ^[[:upper:]] ]]; then
      PASSWORD_PART="${(U)PASSWORD_PART}"
    else
      PASSWORD_PART="${(L)PASSWORD_PART}"
    fi

    if [[ -n "$RESULT" ]]; then
      RESULT="$RESULT-$PASSWORD_PART"
    else
      RESULT=$PASSWORD_PART
    fi
  done
  echo $RESULT
}
