export PATH="$HOME/.tfenv/bin:$PATH"

if [[ ! -d "$HOME/.tfenv/bin" ]]; then
  echo "tfenv: Installing..."
  git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
  tfenv install
  tfenv use
fi

if (( ! $+commands[terraform-config-inspect] ))
  echo "terraform-config-inspect: Installing..."
  go install github.com/hashicorp/terraform-config-inspect@latest
fi
