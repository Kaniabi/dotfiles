# System basic commands

function __fix_max_user_watches () {
  # Fix the max user watches so VSCode doesn't complain.
  local new_max=524288
  local current=$(cat /proc/sys/fs/inotify/max_user_watches)
  if [[ $current -ge $new_max ]]; then
    return
  fi
  echo "fs.inotify.max_user_watches=$new_max" | sudo tee /etc/sysctl.d/40-max-user-watches.conf
  sudo sysctl --system
}

( ! $IS_MAC ) && __fix_max_user_watches


INSTALL_CMD unzip
INSTALL_CMD zip
INSTALL_CMD jq
INSTALL_CMD ts moreutils # ts, parallel, chronic
INSTALL_CMD multitail
INSTALL_CMD gawk
INSTALL_CMD tmux
INSTALL_CMD btop
INSTALL_CMD make
INSTALL_CMD bzip2
INSTALL_CMD envsubst gettext-base
( ! $IS_MAC ) && INSTALL_CMD inotifywait inotify-tools
INSTALL_CMD strings binutils

if ( ! $IS_MAC ); then
  INSTALL_CMD realpath coreutils
  function grealpath { realpath "$@" }
else
  INSTALL_CMD grealpath coreutils
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

function block_for_change {
  [[ -z "${1-}" ]] && echo "Usage: block_for_change <PATH>" && exit 9
  inotifywait --recursive \
    --event modify,move,create,delete \
    $1
}
