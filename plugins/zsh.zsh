# export ZPLUG_HOME=~/.zplug
# if [[ ! -f ~/.zplug/init.zsh ]]; then
#   git clone https://github.com/zplug/zplug $ZPLUG_HOME
# fi
# SOURCE ~/.zplug/init.zsh
# zplug "zsh-users/zsh-syntax-highlighting", defer:2

# # ZSH specific packages and extensions
# if [[ ! -f ~/.zpm/zpm.zsh ]]; then
#   git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
# fi
# source ~/.zpm/zpm.zsh
# zpm load zpm-zsh/colors
# zpm load zsh-users/zsh-syntax-highlighting


INSTALL_PKG zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
