# DOCKER
# alias dd="sudo docker"
# alias ddi="sudo docker images"
# alias ddps="sudo docker ps"

function ddr () {
  docker-compose run "$@"
}

function ddb () {
  docker-compose build "$@"
}

function ddup () {
  docker-compose up "$@"
}

function ddstop () {
  docker-compose stop "$@"
}
