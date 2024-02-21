apt_install_cmd nala
alias apt="sudo nala"

apt_install_cmd batcat bat
alias cat=batcat

apt_install_cmd jq

apt_install_cmd parallel

apt_install_cmd ag silversearcher-ag
alias ag="\ag --hidden"

apt_install_cmd unzip

apt_install_cmd wget

apt_install_cmd exa
alias dir="exa -la"

apt_install_cmd nvim neovim
alias vim="nvim"
export EDITOR='nvim'

# TODO: This is failing on Debian12 (remote-machine).
#if (( ! $+commands[locale-gen] ))
#then
#  sudo apt install locales
#  sudo locale-gen en_US.UTF-8
##  echo "LANGUAGE=en_US.UTF-8
##LC_ALL=en_US.UTF-8
##LANGUAGE=en_US.UTF-8" | sudo tee /etc/default/locale
#  echo "locales locales/default_environment_locale select en_US.UTF-8" | sudo debconf-set-selections
#  echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | sudo debconf-set-selections
#  sudo dpkg-reconfigure --frontend noninteractive locales
#fi
