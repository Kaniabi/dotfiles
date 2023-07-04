local PREFIX="zops aws"
for i_cmd in ami.list ami.build ec2.list ec2.shell ec2.start asg.list asg.update params.list params.put params.get params.set; do
  alias $i_cmd="$PREFIX $i_cmd"
done
alias ec2.user_data="$PREFIX ec2.shell --command=\"tail -n50 /var/log/user-data.log\""
alias ec2.docker_ps="$PREFIX ec2.shell --command=\"sudo docker ps -a\""
