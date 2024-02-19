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

function _redev_aws () {
  aws --profile $REDEV_PROFILE --region=$REDEV_REGION "$@"
}

function redev () {
  REDEV_PROFILE="internal"
  REDEV_REGION="ca-central-1"
  REDEV_INSTANCE_ID="i-0ab78ef84f55fa9b7"
  REDEV_SECURITY_GROUP_ID="sg-0a09dfd46f63d075b"
  REDEV_SECURITY_GROUP_NAME="mi-is-infra_kaniabi"

  CMD=$1
  case $CMD in
    "list")
      _redev_aws ec2 describe-instances --instance-ids=$REDEV_INSTANCE_ID | jq -r '.Reservations[] | .Instances[] | "InstanceId: \(.InstanceId)\nPublicIpAddress: \(.PublicIpAddress)\nState: \(.State.Name)"'
      ;;
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
    "set_ingress")
      CURRENT_IP=$(curl ifconfig.co)
      echo "*** Add ingress rules for current ip ($CURRENT_IP) ..."
      _redev_aws ec2 authorize-security-group-ingress --group-id $REDEV_SECURITY_GROUP_ID --protocol tcp --port 22 --cidr $CURRENT_IP/32
      echo "*** Done."
      ;;
    *)
      echo "
redev: Remote Development tool

* list
* start
* stop

PROFILE=$REDEV_PROFILE
REGION=$REDEV_REGION
INSTANCE_ID=$REDEV_INSTANCE_ID
"
      ;;
  esac
}
