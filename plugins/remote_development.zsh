
# Remote Development

function _redev_aws () {
  aws --profile $REDEV_PROFILE --region=$REDEV_REGION "$@"
}

function redev () {
  export REDEV_PROFILE="mi-is"
  # export REDEV_REGION="ca-central-1"
  # export REDEV_SECURITY_GROUP_NAME="mi-is-infra_kaniabi"
  # export REDEV_INSTANCE_ID="$(_redev_aws ec2 describe-instances --filters "Name=tag:Name,Values=$REDEV_SECURITY_GROUP_NAME" --query "Reservations[*].Instances[*].[InstanceId]" --output text | tail -n1)"
  export REDEV_REGION="us-east-2"
  export REDEV_SECURITY_GROUP_NAME="mi-is-infra_kaniabi"
  export REDEV_INSTANCE_ID="$(_redev_aws ec2 describe-instances --filters "Name=tag:Name,Values=$REDEV_SECURITY_GROUP_NAME" --query "Reservations[*].Instances[*].[InstanceId]" --output text | tail -n1)"

  CMD=$1
  case $CMD in
    "start")
      INFO "Starting remote development instance..."
      _redev_aws ec2 start-instances --instance-ids=$REDEV_INSTANCE_ID
      INFO "Done."
      ;;
    "stop")
      INFO "*** Stopping remote development instance..."
      _redev_aws ec2 stop-instances --instance-ids=$REDEV_INSTANCE_ID
      INFO "*** Done."
      ;;
    "shell")
      INFO "*** Shell into remote development instance..."
      _redev_aws ssm start-session --target=$REDEV_INSTANCE_ID
      INFO "*** Done."
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
