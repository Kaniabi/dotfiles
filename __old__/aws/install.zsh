if [[ $(uname) != "Darwin" ]]; then
  # START awscli
  # INSTALL_CMD aws https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
  # ./install
  if [[ ! -f /usr/local/bin/aws ]]; then
    echo "awscliv2: Installing..."
    curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
    unzip -q /tmp/awscliv2.zip -d /tmp
    sudo /tmp/aws/install
    rm -rf /tmp/aws
    rm -rf /tmp/awscliv2.zip
  fi

  # START session-manager-plugin
  # INSTALL_CMD session-manager-plugin https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb
  if [[ ! -f /usr/local/bin/session-manager-plugin ]]; then
    echo "session-manager-plugin: Installing..."
    curl --silent "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
    sudo dpkg -i /tmp/session-manager-plugin.deb
    rm /tmp/session-manager-plugin.deb
  fi

  # START sam
  # INSTALL_CMD sam https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip

  if [[ ! -f /usr/local/bin/sam ]]; then
    echo "sam: Installing..."
    mkdir -p /tmp/sam-installation
    wget "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -P "/tmp"
    unzip -q /tmp/aws-sam-cli-linux-x86_64.zip -d /tmp/sam-installation
    sudo /tmp/sam-installation/install
    rm -rf /tmp/sam-installation
    rm -rf /tmp/aws-sam-cli-linux-x86_64.zip
  fi

  # START ecs-cli
  # INSTALL_CMD https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest /usr/local/bin/ecs-cli
  if [[ ! -f /usr/local/bin/ecs-cli ]]; then
    echo "ecs-cli: Installing..."
    sudo wget --quiet https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest -O /usr/local/bin/ecs-cli
    sudo chmod +x /usr/local/bin/ecs-cli
  fi
fi

FINISH
