# Docker aliases and functions.

alias dd="docker compose"
alias ddb="docker compose build"
alias dr="docker run -it --rm"
alias ddr="docker compose run --rm"
alias docker-compose="docker compose"

function dbash () {
  docker run --rm -it $1 bash
}

function dive () {
  docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive "$@"
}
