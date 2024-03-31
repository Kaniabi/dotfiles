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
