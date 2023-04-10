# TODO: How to check for newer versions?
#sudo add-apt-repository -y ppa:git-core/ppa
#sudo apt update
#sudo apt install -q --upgrade git

# Query/use custom command for `git`.
# zstyle -s ":vcs_info:git:*:-all-" "command" _omz_git_git_cmd
# : ${_omz_git_git_cmd:=git}

alias gbranches='git branch --format="%(refname:short)" | xargs git lg'
alias grebase='git rebase --interactive --autosquash'

function gwip() {
  git commit -am "WIP: $*"  && \
  gpush
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
  git branch -v  ## --format="%(refname:short)"
}

function ggb () {
  git branch -av
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
  find -name .git | xargs realpath | xargs dirname | grep -v "\." | sort
}

function ggfetch () {
  REPOS=$(ggrepos)
  parallel gfetch ::: $REPOS
}

function ggpull () {
  REPOS=$(ggrepos)
  for i_repo in ${(f)REPOS}; do
    echo "********************************************************************* $(basename $i_repo)"
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
    echo "********************************************************************* $(basename $i_repo)"
    hub -C $i_repo "$@"
  done
}
