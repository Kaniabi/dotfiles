FROM debian:bookworm

WORKDIR /root/.dotfiles
ADD ./bootstrap ./
RUN ./bootstrap
ADD . ./
