# Terminal multiplexer.

CMD=zellij
if (( ! $+commands[$CMD] )); then
  DOWNLOAD https://github.com/zellij-org/zellij/releases/download/v0.40.1/zellij-x86_64-unknown-linux-musl.tar.gz
  tar xf zellij-x86_64-unknown-linux-musl.tar.gz
  sudo mv $CMD /usr/local/bin
fi
