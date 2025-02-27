# IaC tool.

EXPORT PATH "$PATH:$HOME/.tfenv/bin"
EXPORT TF_LOG ERROR
EXPORT TF_X_CONCISE_DIFF 1

if (( ! $+commands[tfenv] )); then
  INSTALL_GIT https://github.com/tfutils/tfenv.git $HOME/.tfenv
fi
# TEST_CMD tfenv --version

go_install_cmd terraform-config-inspect github.com/hashicorp/terraform-config-inspect@latest

#=================================================================================================== Functions

function tfw () {
  if [[ -z $1 ]]; then
    terraform workspace list
  else
    terraform workspace select "$@"
  fi
}

function _tf_usage () {
  echo "
Usage:
  _tf init
  _tf <CMD> <WORKSPACE> <*PARAMS>
Availabe workspaces:
$(ls -1 './tfvars' | gawk '{ sub(/.tfvars/, "", $1); print("  *", $1) }')
"
  exit 0
}

function _tf_title () {
  COLOR='\033[0;34m'
  RESET='\033[0m'
  echo -e "${COLOR}# $*${RESET}"
}


function _tf() {
  # Case 1: No tfvars: just run the terraform command.
  if [[ ! -d "tfvars" ]]; then
    _tf_title "Checking tfvars: ./tfvars not found. Running terraform."
    terraform "$@"
    return
  else
    _tf_title "Checking tfvars: ./tfvars directory found. Using tfvars."
  fi

  # Case 2: localbin directory: run the local bin script
  local CMD=$1
  LOCALBIN_CMD="bin/%CMD"
  if [[ -f $LOCALBIN_CMD ]]; then
    _tf_title "Checking localbin: ./bin found. Running $LOCALBIN_CMD"
    return 0
  else
    _tf_title "Checking localbin: ./bin directory not found. Not using localbin."
  fi

  if [[ "$CMD" == "init" ]]; then
    _tf_title "Checking init command: Running terraform init."
    terraform init
    return
  fi

  # Cluster
  local VAR_FILENAME=$2
  shift 2
  local CLUSTER=${VAR_FILENAME%%-*}
  _tf_title "CLUSTER=$CLUSTER"

  # Workspace: we have variations, the new one with `app-env` and the old one
  # with only `env`.
  _tf_title "Checking workspace variation: app-env vs env"
  if terraform workspace list | grep -w "$VAR_FILENAME" >> /dev/null 2>&1; then
    local WORKSPACE=$VAR_FILENAME
    _tf_title "WORKSPACE=$WORKSPACE"
  else
    local WORKSPACE=${VAR_FILENAME#*-}
    _tf_title "WORKSPACE=$WORKSPACE"
  fi

  # Switch workspace if needed.
  local WORKSPACE_CURRENT=$(terraform workspace show)
  if [[ "$WORKSPACE_CURRENT" != "$WORKSPACE" ]]; then
    terraform workspace select "$WORKSPACE"
    WORKSPACE_CURRENT=$(terraform workspace show)
    if [[ "$WORKSPACE_CURRENT" != "$WORKSPACE" ]]; then
      _tf_title "ERROR: Terraform workspaces switch failed. Desired: $WORKSPACE, Current: $WORKSPACE_CURRENT."
      return 9
    fi
  fi

  echo terraform $CMD -var-file "./tfvars/$VAR_FILENAME.tfvars" "$@"
  terraform $CMD -var-file "./tfvars/$VAR_FILENAME.tfvars" "$@"
}

function tfi() {
  _tf init "$@"
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
  find -name .terraform | xargs grealpath | xargs dirname | grep -v "\."
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

function tfapply() {
  for i in "$@"; do
    echo "****************************************************************************************** $i"
    APP="${i%-*}"
    cd $HOME/Code/autosync/iac/terraform/apps/$APP
    _tf apply "$i"
  done
}

function ttfapply() {
  for i in "$@"; do
    echo "****************************************************************************************** $i"
    APP="${i%-*}"
    cd $HOME/Code/autosync/iac/terraform/apps/$APP
    _tf apply "$i" -auto-approve
  done
}

# function tfapply () {
#   if [[ -z $1 ]]; then
#     echo "Usage: tfapply <ENVIRONMENT>"
#     exit 9
#   fi
#   if [[ $1 == "prod" ]]; then
#     echo "ERROR: You should not use this command for production environment."
#     exit 9
#   fi
#   tfi
#   tfw "$1"
#   tfa -auto-approve
#   # asg.update "$1" 2
#   #sleep 150
#   #asg.update "$1" 1
# }

function tfplan () {
  tfi
  tfp "$@"
}