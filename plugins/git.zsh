# Source code version system.

INSTALL_CMD git

INSTALL_CMD hub
eval "$(hub alias -s zsh)"

INSTALL_CMD gh

# Aliases

function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function gwip() {
  git commit -am "WIP: $*"  && \
  gpush
}

function gshow() {
  git show --name-status "$@"
}

function grev () {
  git commit -am "REV: $*"  && \
  gpush
}

function gsquash () {
  [[ -z "$1" ]] && echo "Usage: gsquash <BRANCH>" && return 9
  local HEAD=$(git rev-parse HEAD)
  git reset --hard $1
  git merge --squash $HEAD
}

function workon () {
  if [[ $1 == "" ]]; then
    pyenv versions
  else
    pyenv shell $1
  fi
}

function grom () {
  git checkout $1 && \
  git rebase ${2:-master} && \
  gpush
}

function gb () {
  git for-each-ref  \
    --sort=committerdate refs/heads/ \
    --format='%(color:yellow)%(align:width=32)%(refname:lstrip=2)%(end)%(color:reset): %(contents:subject) %(color:green)(%(committerdate:relative))%(color:blue) %(authorname)%(color:reset)'
}

function gbst () {
  for i_branch in $( gb ); do printf "$i_branch "; hub ci-status $i_branch; done;
}

function gretag () {
  [[ -z $1 ]] && die "Usage: gretag <TAG>"
  hub tag -d $1
  hub tag $1
  hub push origin --force $1
}

function gpush () {
  hub push --set-upstream origin "$@" $(git_current_branch)
}

function gpull () {
  hub pull
}

# alias gamend='git add -A .;git amend;gpush -f'
# alias gamendn='git add -A .;git commit -an --amend;gpush -f'
function gamend () {
  hub add -A .
  hub commit --amend --no-edit --all
}

function ggrepos () {
  find . -name .git | xargs dirname | grep -v "/\." | grep -v "/__" | sort
}

function ggfetch () {
  REPOS=$(ggrepos)
  parallel gfetch ::: $REPOS
}

function ggpull () {
  REPOS=$(ggrepos)
  for i_repo in ${(f)REPOS}; do
    echo "********************************************************************* $i_repo"
    hub -C $i_repo pull
  done
}

function ggst () {
  REPOS=$(ggrepos)
  for i_repo in ${(f)REPOS}; do
    echo -n "`realpath --relative-to=$PWD $i_repo`  "
    hub -C $i_repo st  # | tail -n +2
  done
}

function gg () {
  REPOS=$(ggrepos)
  for i_repo in ${(f)REPOS}; do
    echo "********************************************************************* $i_repo"
    hub -C $i_repo "$@"
  done
}

function gdiff() {
  git diff --name-status "${@:-master}"
}
