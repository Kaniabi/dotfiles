export PKENVDIR="$HOME/.pkenv"
git_install https://github.com/iamhsa/pkenv.git $PKENVDIR
export PATH="$PATH:$PKENVDIR"

export TFENVDIR="$HOME/.tfenv"
git_install https://github.com/tfutils/tfenv.git $TFENVDIR
export PATH="$HOME/.tfenv/bin:$PATH"

if (( ! $+commands[terraform] ))
then
  tfenv install latest
  tfenv use
fi

go_install_cmd terraform-config-inspect github.com/hashicorp/terraform-config-inspect@latest
