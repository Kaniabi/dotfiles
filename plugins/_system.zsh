# System basic commands

INSTALL_CMD curl
INSTALL_CMD parallel
INSTALL_CMD unzip
INSTALL_CMD wget
INSTALL_CMD jq


function ffind () {
  echo "find . -name '*$1*'"
  find . -name "*$1*"
}
