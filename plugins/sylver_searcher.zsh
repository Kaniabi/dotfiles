# Find in files

if ( $IS_MAC ); then
  INSTALL_CMD ag the_silver_searcher
else
  INSTALL_CMD ag silversearcher-ag
fi
ALIAS ag "\ag --hidden"
