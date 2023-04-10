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

function dbash () {
  docker run -it "$@" bash
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

function di () {
  docker images
}

function dkill () {
  echo "dkill: Killing all containers."
  docker ps -q | xargs -r docker kill  || true
  echo "dkill: Deleting all containers."
  docker ps -q -a | xargs -r docker rm
}

function dprune () {
  echo "dcls: Deleting exited containers."
  docker ps -q -a | xargs -r docker rm
  echo "dcls: Deleting dangling images."
  docker images -q | xargs -r docker rmi
}

function dclear () {
  echo "dclear: Deleting exited containers."
  docker ps -q -a -f "status=exited" | xargs -r docker rm
  echo "dclear: Deleting dangling images."
  docker images -q -f dangling=true | xargs -r docker rmi
}
