# DOCKER
# alias dd="sudo docker"
# alias ddi="sudo docker images"
# alias ddps="sudo docker ps"

export DEV_DOCKER_DIR=/d/Projects/unhaggle/dev_docker

function ddr () {
  docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml run "$@"
}

function ddbuild () {
  docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml build "$@"
}

function ddup () {
  docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml up "$@"
}

function ddstop () {
  docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml stop "$@"
}

function ddcog () {
  cog -r $DEV_DOCKER_DIR/dev_docker/docker-compose.yml
}
