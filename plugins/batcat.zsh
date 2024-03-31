# Replacement for cat

if ( $IS_MAC ); then
  INSTALL_CMD bat
  ALIAS cat bat
else
  INSTALL_CMD batcat bat
  ALIAS cat batcat
fi
