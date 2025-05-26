# Rust language and cargo

# TODO:....
# # REF: https://doc.rust-lang.org/cargo/getting-started/installation.html
# # ORIGINAL: curl https://sh.rustup.rs -sSf | sh
# EXPORT PATH=$PATH:$HOME/.cargo/bin
# INSTALL_CMD cargo

if (( ! $+commands[cargo] )); then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  EXTRACT_URL  \
    https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz  \
    $HOME/.cargo/bin/cargo-binstall
fi
