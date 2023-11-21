export AUTOSYNC_DIR=$HOME/autosync
export AUTOSYNC_DATA=$AUTOSYNC_DIR/_data
export DATA_DIR=$AUTOSYNC_DIR/_data

# Configuration for as-core-service
export AS_CORE_SERVICE_ROOT_DIR=$HOME/autosync/as/core_service
export AS_CORE_SERVICE_USER_SECRETS_DIR=$AS_CORE_SERVICE_ROOT_DIR/.secrets

def _setup_mi_vars () {
  local VAR_NAME=${1#*/}
  VAR_NAME=${VAR_NAME:u}
  if [[ -n "$2" ]]; then
    VAR_NAME=$2
  fi
  local VAR_REPO="${VAR_NAME}_REPO"
  local VAR_DATA="${VAR_NAME}_DATA"

  export $VAR_REPO=$AUTOSYNC_DIR/$1
  export $VAR_DATA=$AUTOSYNC_DIR/_data

  [[ ! -d ${(P)VAR_REPO} ]] && echo "ERROR: Invalid directory ${VAR_REPO}=${(P)VAR_REPO}"
  [[ ! -d ${(P)VAR_DATA} ]] && echo "ERROR: Invalid directory ${VAR_DATA}=${(P)VAR_DATA}"

  echo "$VAR_REPO=${(P)VAR_REPO}"
  echo "$VAR_DATA=${(P)VAR_DATA}"
}

if [[ -d $AUTOSYNC_DIR ]]; then
  _setup_mi_vars apps/unhaggle
  _setup_mi_vars apps/tier3
  _setup_mi_vars apps/tier1
  _setup_mi_vars apps/unhaggle
  _setup_mi_vars apps/polestar
  _setup_mi_vars apps/bp
  _setup_mi_vars apps/pi
  _setup_mi_vars apps/peb
  _setup_mi_vars apps/creditapp
  _setup_mi_vars apps/centralpanel

  _setup_mi_vars libs/api_clients
  _setup_mi_vars libs/core UH_CORE
  _setup_mi_vars libs/moto MOTO_CORE
  _setup_mi_vars libs/status UH_STATUS
  _setup_mi_vars libs/inventory UH_INVENTORY
  _setup_mi_vars libs/tierless

  export CAWS_REPO=$AUTOSYNC_DIR/apps/credit-app
  export CONTAINER_UID=$(id -u)
fi
