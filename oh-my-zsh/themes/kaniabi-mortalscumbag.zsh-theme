function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

function _bold_blue () {
  echo "%F{blue}$1%f"
}

function _bold_yellow () {
  echo "$fg_bold[yellow]$1$reset_color"
}

function _bold_green () {
  echo "%F{green}$1%f"
}

function _prompt_ssh() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "$fg_bold[red](ssh)%f"
  fi
}

function _prompt_git() {
  REPO=$(git rev-parse --git-dir 2> /dev/null) || return
  echo " git:$(_bold_blue ${REPO:a:h:t})@$(_bold_yellow $(my_current_branch))"
}

function _prompt_venv() {
  [[ -z $PYENV_VERSION ]] && return
  echo " pyenv:$(_bold_blue ‹$PYENV_VERSION›)"
}

function _prompt_terraform() {
  if [[ ! -d .terraform ]] && return
  local TERRAFORM_WORKSPACE="$(terraform workspace show)"
  local COLOR=blue
  if [[ "$TERRAFORM_WORKSPACE" == "prod" ]] && COLOR=red;
  if [[ "$TERRAFORM_WORKSPACE" == "stage" ]] && COLOR=yellow;
  if [[ "$TERRAFORM_WORKSPACE" == "qa" ]] && COLOR=yellow;
  if [[ "$TERRAFORM_WORKSPACE" == "dev" ]] && COLOR=green;
  echo " terraform:%F{$COLOR}$TERRAFORM_WORKSPACE%f"
}

_prompt_login="$(_bold_green %n@%m)"
_prompt_return_code="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"

PROMPT=$'
$(_prompt_ssh)${_prompt_login}$(_prompt_venv)$(_prompt_git)$(_prompt_terraform)
%~
[${_prompt_return_code}] %{$fg_bold[blue]%}λ%{$reset_color%} '
RPROMPT='[%*]'

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
