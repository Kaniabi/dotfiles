# Replacement for cat

if ( $IS_MAC ); then
  INSTALL_CMD bat
  ALIAS cat 'bat --theme="Coldark-Cold"'
else
  INSTALL_CMD batcat bat
  ALIAS cat 'batcat --theme="Coldark-Cold"'
fi
