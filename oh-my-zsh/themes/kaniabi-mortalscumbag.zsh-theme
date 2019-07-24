function my_git_prompt() {
  REPO=$(git rev-parse --git-dir 2> /dev/null) || return

  echo "%{$fg_bold[yellow]%}%}${REPO:a:h:t}%{$fg_bold[white]%} @ %{$fg_bold[yellow]%}$(my_current_branch)%{$reset_color%} : "
}

function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(ssh) "
  fi
}

function my_login() {
  echo "%{$fg_bold[green]%}%n@%m%{$reset_color%}"
}

function my_environment() {
  if [[ -n $PYENV_VERSION ]]; then
    echo " %{$fg_bold[blue]%}‹$PYENV_VERSION›%{$reset_color%}"
  fi
}

ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"
PROMPT=$'\n$(ssh_connection)$(my_login)$(my_environment)\n$(my_git_prompt)%~\n[${ret_status}] %{$fg_bold[blue]%}λ%{$reset_color%} '

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
