alias tf="terraform"
alias tfi="terraform init"
alias tfd="terraform destroy"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tfw="terraform workspace select"

function tfpp() {
  local TFPLAN_FILENAME=~/autosync/_work/tfplans/$(basename $PWD)-$(terraform workspace show).tfplan
  terraform init
  terraform plan -no-color > $TFPLAN_FILENAME
  echo "file://$TFPLAN_FILENAME"
}
