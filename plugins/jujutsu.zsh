# Source code version system.

CMD=jj
if (( ! $+commands[$CMD] )); then
  DOWNLOAD https://github.com/martinvonz/jj/releases/download/v0.20.0/jj-v0.20.0-x86_64-unknown-linux-musl.tar.gz
  tar xf jj-v0.20.0-x86_64-unknown-linux-musl.tar.gz
  sudo mv $CMD /usr/local/bin
fi
