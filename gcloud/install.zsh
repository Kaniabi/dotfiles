if [[ $(uname) != "Darwin" ]]; then
  if [[ ! -f /usr/bin/gcloud ]]; then
    echo "gcloud: Installing..."
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.asc
    sudo apt-get update
    sudo apt-get install google-cloud-cli
  fi
fi
