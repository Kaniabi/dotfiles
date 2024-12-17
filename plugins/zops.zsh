# Zero Operations AWS commands

local ZOPS_AWS_PREFIX="zops aws"
for i_cmd in ami.list ami.build ec2.list ec2.shell ec2.start asg.list asg.update params.list params.put params.get params.set; do
  alias $i_cmd="$ZOPS_AWS_PREFIX $i_cmd"
done
alias ec2.user_data="$ZOPS_AWS_PREFIX ec2.shell --command=\"tail -n50 /var/log/user-data.log\""
alias ec2.docker_ps="$ZOPS_AWS_PREFIX ec2.shell --command=\"sudo docker ps -a\""

function codegen () {
  zz codegen apply .
  terraform fmt --recursive . && git diff -w .
}

# Zops
# alias zops="poetry -C ~/Code/zops run zops"
# alias zz="poetry -C ~/Code/zops run zz"
