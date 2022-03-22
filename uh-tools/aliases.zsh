for i_cmd in ami.list ami.build ec2.list ec2.shell ec2.start asg.list asg.update; do
  alias $i_cmd="uh aws $i_cmd"
done
