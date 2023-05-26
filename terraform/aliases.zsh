alias tfi="terraform init"
alias tfw="terraform workspace select"

function tf () {
  if [[ -d "tfvars" ]]; then
    local PROJECT=$(basename $PWD)
    PROJECT=${PROJECT%%-*}
    local WORKSPACE=$(terraform workspace show)
    local _AWS_PROFILE=mi-$WORKSPACE
    echo AWS_PROFILE=$_AWS_PROFILE $CMD -var-file tfvars/$PROJECT-$WORKSPACE.tfvars
    AWS_PROFILE=$_AWS_PROFILE terraform ${@} -var-file tfvars/$PROJECT-$WORKSPACE.tfvars
  else
    terraform ${@}
  fi
}

function tfp() {
  tf plan $@
}

function tfa() {
  tf apply $@
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
