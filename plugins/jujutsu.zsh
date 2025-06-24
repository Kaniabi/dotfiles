# Source code version system.

if (( ! $+commands[jj] )); then
  if ( $IS_MAC ); then
    cargo binstall --strategies crate-meta-data jj-cli
  else
    cargo install jj-cli
  fi
fi
