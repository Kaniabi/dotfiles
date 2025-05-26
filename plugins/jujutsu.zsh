# Source code version system.

if (( ! $+commands[jj] )); then
  cargo binstall --strategies crate-meta-data jj-cli
fi
