# TODO: How to check for newer versions?
#sudo add-apt-repository -y ppa:git-core/ppa
#sudo apt update
#sudo apt install -q --upgrade git

function gfetch() {
  local REPOS=$(find -name .git | xargs realpath | xargs dirname | grep -v "\.")
  parallel gfetch-one ::: $REPOS
}
