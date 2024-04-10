# 'AWS CLI and friends'

if ( $IS_MAC ); then
  INSTALL_CMD aws awscli
else
  INSTALL_CMD aws "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  # NOTE: Not working in remote dev.
  # INSTALL_CMD session-manager-plugin "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
  # INSTALL_CMD sam "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
  # INSTALL_CMD ecs-cli "https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest"
fi

# Aliases

function awsin () {
  aws sso login --profile=$1
}

function awsout () {
  aws sso logout --profile=$1
}
