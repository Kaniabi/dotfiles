export AUTOSYNC_DIR=$HOME/autosync
export AUTOSYNC_DATA=$AUTOSYNC_DIR/_data
export DATA_DIR=$AUTOSYNC_DIR/_data

# Configuration for as-core-service
export AS_CORE_SERVICE_ROOT_DIR=$HOME/autosync/as/core_service
export AS_CORE_SERVICE_USER_SECRETS_DIR=$AS_CORE_SERVICE_ROOT_DIR/.secrets

function _setup_mi_vars () {
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

  # echo "$VAR_REPO=${(P)VAR_REPO}"
  # echo "$VAR_DATA=${(P)VAR_DATA}"
}

if [[ -d $AUTOSYNC_DIR ]]; then
  _setup_mi_vars apps/unhaggle
  _setup_mi_vars apps/tier3
  _setup_mi_vars apps/tier1
  _setup_mi_vars apps/unhaggle
  _setup_mi_vars apps/pi
  _setup_mi_vars apps/peb
  _setup_mi_vars apps/centralpanel

  _setup_mi_vars as/creditapp

  _setup_mi_vars libs/api_clients
  _setup_mi_vars libs/core UH_CORE
  _setup_mi_vars libs/moto MOTO_CORE
  _setup_mi_vars libs/status UH_STATUS
  _setup_mi_vars libs/inventory UH_INVENTORY
  _setup_mi_vars libs/tierless

  export CAWS_REPO=$AUTOSYNC_DIR/apps/credit-app
  export CONTAINER_UID=$(id -u)
fi

function _redev_aws () {
  aws --profile $REDEV_PROFILE --region=$REDEV_REGION "$@"
}

function redev () {
  REDEV_PROFILE="mi-is"
  REDEV_REGION="us-east-2"
  REDEV_INSTANCE_ID="i-0fe8ea64965ee0a60"
  REDEV_SECURITY_GROUP_ID="sg-0a09dfd46f63d075b"
  REDEV_SECURITY_GROUP_NAME="mi-is-infra_kaniabi"

  CMD=$1
  case $CMD in
    "start")
      echo "*** Starting remote development instance..."
      _redev_aws ec2 start-instances --instance-ids=$REDEV_INSTANCE_ID
      echo "*** Done."
      ;;
    "stop")
      echo "*** Stopping remote development instance..."
      _redev_aws ec2 stop-instances --instance-ids=$REDEV_INSTANCE_ID
      echo "*** Done."
      ;;
    "shell")
      echo "*** Shell into remote development instance..."
      _redev_aws ssm start-session --target=$REDEV_INSTANCE_ID
      echo "*** Done."
      ;;
    "ingress")
      echo "*** List current ingress rules..."
      _redev_aws ec2 describe-security-groups --group-ids=$REDEV_SECURITY_GROUP_ID | jq -r ".SecurityGroups[] | .IpPermissions[] | .IpRanges[] | .CidrIp"
      echo "*** Done."
      ;;
    "ingress.set")
      CURRENT_IP=$(curl ifconfig.co)
      echo "*** Add ingress rules for current ip ($CURRENT_IP) ..."
      _redev_aws ec2 authorize-security-group-ingress --group-id $REDEV_SECURITY_GROUP_ID --protocol tcp --port 22 --cidr $CURRENT_IP/32
      echo "*** Done."
      ;;
    *)
      echo "
redev: Remote Development tool

Commands:
  * start: Starts the instance.
  * stop: Stops the instance.
  * shell: Start a SSM session.
  * ingress: List ingress rules.
  * ingress.set: Add a new ingress rule for the current IP.

PROFILE=$REDEV_PROFILE
REGION=$REDEV_REGION
INSTANCE_ID=$REDEV_INSTANCE_ID"
      _redev_aws ec2 describe-instances --instance-ids=$REDEV_INSTANCE_ID | jq -r '.Reservations[] | .Instances[] | "INSTANCE_IP: \(.PublicIpAddress)\nINSTANCE_STATE: \(.State.Name)"'
      ;;
  esac
}

function autosync_repos () {
  IFS=$'\n' ALL_REPOS=($(gh repo list tdr-autosync --limit=1000 --no-archived --json name --jq ".[] | .name" | sort))
  echo "AutoSync repositories:"
  SKIP_COUNT=0
  for i_repo in ${ALL_REPOS[@]}; do
    LOCAL_DIR=""
    case $i_repo in
      "mi-infra-iac")
        LOCAL_DIR="autosync/iac"
        ;;
      "mi-infra-baseimages")
        LOCAL_DIR="autosync/baseimages"
        ;;
      "mi-infra*")
        LOCAL_DIR="autosync/infra/${i_repo##*-}"
        ;;
      "mi-app-"*)
        LOCAL_DIR="autosync/apps/${i_repo##*-}"
        ;;
      "qa")
        LOCAL_DIR="autosync/apps/${i_repo##*-}"
        ;;
      "mi-lib-"*)
        LOCAL_DIR="autosync/libs/${i_repo##*-}"
        ;;
      "as-app-"*)
        LOCAL_DIR="autosync/as/${i_repo##*-}"
        ;;
      "as-lib-"*)
        LOCAL_DIR="autosync/as/${i_repo##*-}"
        ;;
      "mi-tfmodule"*)
        LOCAL_DIR="autosync/tfmodules/${i_repo##*-}"
        ;;
      *)
        (( SKIP_COUNT+=1 ))
        ;;
      esac
      if [[ -n $LOCAL_DIR ]]; then
        if [[ -d "$HOME/$LOCAL_DIR" ]]; then
          printf "%s: %s: ok\n" $i_repo $LOCAL_DIR
          continue
        fi
        printf "%s: %s: cloning repo.\n" $i_repo $LOCAL_DIR
        git clone --quiet "git@github.com:tdr-autosync/$i_repo" $LOCAL_DIR
      fi
  done
  echo "$SKIP_COUNT skipped."
}
