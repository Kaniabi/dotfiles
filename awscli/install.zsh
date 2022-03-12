if [[ ! -f /usr/local/bin/aws ]]; then
  echo "awscliv2: Installing..."
  curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install
  rm -rf /tmp/aws
  rm -rf /tmp/awscliv2.zip
fi
