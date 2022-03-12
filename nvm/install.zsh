NVM_VERSION=0.39.1
export NVM_DIR="$HOME/.nvm"
if [[ ! -d $NVM_DIR ]]; then
  echo "nvm: Installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
fi

source "$NVM_DIR/nvm.sh"
