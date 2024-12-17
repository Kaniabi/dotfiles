# Docker aliases and functions.

alias dd="docker compose"
alias ddb="docker compose build"
alias dr="docker run -it --rm"
alias ddr="docker compose run --rm"
alias docker-compose="docker compose"

# if not command docker:
#   # Add Docker's official GPG key:
#   sudo apt-get update
#   sudo apt-get install ca-certificates curl
#   sudo install -m 0755 -d /etc/apt/keyrings
#   sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
#   sudo chmod a+r /etc/apt/keyrings/docker.asc
#
#   # Add the repository to Apt sources:
#   echo \
#     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
#     $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#     sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#   sudo apt-get update

function dbash () {
  docker run --rm -it $1 bash
}

function dive () {
  docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive "$@"
}
