# Colorfull directory list (wip)

if ( $IS_MAC ); then
  INSTALL_CMD eza
  ALIAS dir "eza -la"
else
  INSTALL_CMD exa
  ALIAS dir "exa -la"
fi

if ( ! $IS_MAC ); then
  START vivid 'Themes for ls'
  INSTALL_CMD vivid "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
  EXPORT LS_COLORS "$(vivid generate one-dark)"
fi
