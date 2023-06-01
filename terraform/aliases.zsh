alias tfi="terraform init"
alias tfw="terraform workspace select"

function tf () {
  if [[ -d "tfvars" ]]; then
    local WORKSPACE=$(terraform workspace show)
    local DIRNAME=$(basename $PWD)
    local PROJECT=${DIRNAME%%-*}
    if [[ ! "sandbox,dev,stage,qa,prod" =~ (,|^)$WORKSPACE(,|$) ]]; then
      WORKSPACE=dev
    fi
    local _AWS_PROFILE=mi-$WORKSPACE
    if [[ "$WORKSPACE" == "prod" ]]; then
      case $DIRNAME in
        "t3can-cluster")
          _AWS_PROFILE=tier3_cluster
          ;;
        "t3usa-cluster")
          _AWS_PROFILE=tier3_cluster
          ;;
        *)
          _AWS_PROFILE=${DIRNAME/-/_}
          ;;
      esac
    fi
    echo AWS_PROFILE=$_AWS_PROFILE terraform "${@}" -var-file tfvars/$PROJECT-$WORKSPACE.tfvars
    AWS_PROFILE=$_AWS_PROFILE terraform "${@}" -var-file tfvars/$PROJECT-$WORKSPACE.tfvars
  else
    terraform ${@}
  fi
}

function _tf() {
  if [[ ! -d "tfvars" ]]; then
    terraform "$@"
    return
  fi

  if [[ -z "$2" ]]; then
    echo "Usage: _tf <CMD> <WORKSPACE> <*PARAMS>"
    echo "Availabe workspaces:"
    ls -1 './tfvars' | gawk '{ sub(/.tfvars/, "", $1); print("  *", $1) }'
    return 0
  fi
  local CMD=$1
  local VAR_FILENAME=$2
  shift 2
  local CLUSTER="$(cut -d'-' -f1 <<<$VAR_FILENAME)-cluster"
  local WORKSPACE=$(cut -d'-' -f2 <<<$VAR_FILENAME)

  # Switch workspace if needed.
  local WORKSPACE_CURRENT=$(terraform workspace show)
  if [[ "$WORKSPACE" != "$WORKSPACE_CURRENT" ]]; then
    echo "Switching Terraform workspace to $WORKSPACE."
    terraform workspace select "$WORKSPACE"
  fi
  WORKSPACE_CURRENT=$(terraform workspace show)
  if [[ "$WORKSPACE" != "$WORKSPACE_CURRENT" ]]; then
    echo "ERROR: Terraform workspaces switch failed. Desired: $WORKSPACE, Current: $WORKSPACE_CURRENT."
    return 9
  fi

  echo terraform $CMD -var-file "./tfvars/$VAR_FILENAME.tfvars" "$@"
  terraform $CMD -var-file "./tfvars/$VAR_FILENAME.tfvars" "$@"
}

function tfp() {
  _tf plan "$@"
}

function tfa() {
  _tf apply "$@"
}

function tfd() {
  _tf destroy "$@"
}

function tfd () {
  tf destroy $@
}

function tfpp () {
  local TFPLAN_FILENAME=~/autosync/_work/tfplans/$(basename $PWD)-$(terraform workspace show).tfplan
  terraform -chdir=${1:-.} init
  terraform -chdir=${1:-.} plan -no-color > $TFPLAN_FILENAME
  echo "file://$TFPLAN_FILENAME"
}

function tfshow () {
  terraform show .terraform/tfplan.bin
}

function tfrepos () {
  find -name .terraform | xargs realpath | xargs dirname | grep -v "\."
}

function ttfst () {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo $i_repo: $(terraform -chdir=$i_repo workspace show)
  done
}

function ttfst () {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo $i_repo: $(terraform -chdir=$i_repo workspace show)
  done
}

function ttfpp () {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo "********************************************************************* $(basename $i_repo)"
    tfpp $i_repo
  done
}

function tfapply () {
  if [[ -z $1 ]]; then
    echo "Usage: tfapply <ENVIRONMENT>"
    exit 9
  fi
  if [[ $1 == "prod" ]]; then
    echo "ERROR: You should not use this command for production environment."
    exit 9
  fi
  tfi
  tfw "$1"
  tfa -auto-approve
  # asg.update "$1" 2
  #sleep 150
  #asg.update "$1" 1
}
