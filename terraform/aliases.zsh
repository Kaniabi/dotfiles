alias tf="terraform"
alias tfi="terraform init"
alias tfd="terraform destroy"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tfw="terraform workspace select"

function tfpp() {
  local TFPLAN_FILENAME=~/autosync/_work/tfplans/$(basename $PWD)-$(terraform workspace show).tfplan
  terraform -chdir=${1:-.} init
  terraform -chdir=${1:-.} plan -no-color > $TFPLAN_FILENAME
  echo "file://$TFPLAN_FILENAME"
}

function tfrepos() {
  find -name .terraform | xargs realpath | xargs dirname | grep -v "\."
}

function ttfst() {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo $i_repo: $(terraform -chdir=$i_repo workspace show)
  done
}

function ttfst() {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo $i_repo: $(terraform -chdir=$i_repo workspace show)
  done
}

function ttfpp() {
  REPOS=$(tfrepos)
  for i_repo in ${(f)REPOS}; do
    echo "********************************************************************* $(basename $i_repo)"
    tfpp $i_repo
  done
}
