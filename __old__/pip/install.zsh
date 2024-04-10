if (( ! $+commands[pip] ))
then
  echo "*** pip: Installing..."
  sudo apt update -qq
  sudo apt install -qq -y python3-pip python3-virtualenv
fi

# alias pin="pip install --process-dependency-links -U"
# alias pun="pip uninstall -y"

# export PIP_CERT=$DOTFILES/pip/DigiCertHighAssuranceEVRootCA.pem
export PIP_TRUST=pypi.org
