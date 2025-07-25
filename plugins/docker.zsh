# Docker aliases and functions.

alias dd="docker compose"
alias ddb="docker compose build"
alias dr="docker run -it --rm"
alias ddr="docker compose run --rm"
alias docker-compose="docker compose"

if (( ! $+commands[docker] )); then
  if (( $IS_MAC )); then
  else
    echo "Installing docker engine"
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Testing docker engine:"
    sudo docker run hello-world

    echo "Grant user access to docker without sudo."
    sudo usermod -G docker kaniabi
  fi
fi

if ( $IS_MAC ); then
  if [ ! -f "~/.docker/cli-plugins/docker-buildx" ]; then
    echo "Installing docker buildx plugin"
    set -x
    mkdir -p ~/.docker/cli-plugins
    curl -fsSL https://github.com/docker/buildx/releases/latest/download/buildx-v0.26.0.darwin-arm64 -o ~/.docker/cli-plugins/docker-buildx
    chmod +x ~/.docker/cli-plugins/docker-buildx
  fi
  if [ ! -f "~/.docker/cli-plugins/docker-buildx" ]; then
    echo "Installing docker buildx plugin"
    set -x
    mkdir -p ~/.docker/cli-plugins
    curl -fsSL https://github.com/docker/buildx/releases/latest/download/buildx-v0.26.0.darwin-arm64 -o ~/.docker/cli-plugins/docker-buildx
    chmod +x ~/.docker/cli-plugins/docker-buildx
  fi
fi

function dbash () {
  docker run --rm -it $1 bash
}

function dive () {
  docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive "$@"
}
