FROM debian:bookworm

ADD . /root/.dotfiles

RUN apt update && apt install -y sudo git vim zsh unzip wget python3-pip curl
RUN /root/.dotfiles/script/bootstrap
