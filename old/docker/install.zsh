# We don't need this on WSL2.
# export DOCKER_HOST=localhost:2375

# /mnt/c/Users/kania/.aws
# Docker-desktop keeps changing the user .aws folder to link to
# `/mnt/c/Users/kania/.aws`. This makes it point to the aws folder in my
# private configurations repo.
if [[ -d $HOME/projects/private/aws ]]; then
  rm $HOME/.aws
  ln -s $HOME/projects/private/aws $HOME/.aws
fi

# Use docker without sudo.
# sudo setfacl -m user:kaniabi:rw /var/run/docker.sock
