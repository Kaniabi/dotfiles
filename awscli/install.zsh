if [[ ! -f /usr/local/bin/aws ]]; then
  echo "awscliv2: Installing..."
  curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install
  rm -rf /tmp/aws
  rm -rf /tmp/awscliv2.zip
fi

if [[ ! -f /usr/local/bin/session-manager-plugin ]]; then
  echo "session-manager-plugin: Installing..."
  curl --silent "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
  sudo dpkg -i /tmp/session-manager-plugin.deb
  rm /tmp/session-manager-plugin.deb
fi
