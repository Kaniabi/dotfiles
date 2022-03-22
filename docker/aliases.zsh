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

function dlogs () {
  docker logs "$@"
}

function dps () {
  docker ps "$@"
}

function dpsa () {
  docker ps -a "$@"
}

function dcls () {
  docker ps | gawk '{print $1}' | xargs docker kill
  docker ps -a | grep "Exited " | gawk '{print $1}' | xargs docker rm
}
