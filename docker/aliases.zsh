# DOCKER
# alias dd="sudo docker"
# alias ddi="sudo docker images"
# alias ddps="sudo docker ps"

export DEV_DOCKER_DIR=~/Projects/unhaggle/dev_docker

ddr () { docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml run "$@" }
ddbuild () { docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml build "$@" }
ddup () { docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml up "$@" }
ddstop () { docker-compose -f ${DEV_DOCKER_DIR}/dev_docker/docker-compose.yml stop "$@" }
ddcog () { cog -r $DEV_DOCKER_DIR/dev_docker/docker-compose.yml }
