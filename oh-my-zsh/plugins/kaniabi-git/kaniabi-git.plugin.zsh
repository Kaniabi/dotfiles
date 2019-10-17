# Query/use custom command for `git`.
# zstyle -s ":vcs_info:git:*:-all-" "command" _omz_git_git_cmd
# : ${_omz_git_git_cmd:=git}

#
# Functions
#

gwip () {
    git commit -am "WIP: $*"  && \
    gpush
}

grev () {
    git commit -am "REV: $*"  && \
    gpush
}

workon () {
    if [[ $1 == "" ]]; then
        pyenv versions
    else
        pyenv shell $1
    fi
}

grom () {
    git checkout $1 && \
    git rebase ${2:-master} && \
    gpush
}

gpush () {
    git push --set-upstream origin $(git_current_branch) -f
}

gcontinue () {
    git rebase --continue
}

gco () {
    git checkout $*
}

gb () {
    git branch --format="%(refname:short)"
}

gbst () {
    for i_branch in $( gb ); do printf "$i_branch "; hub ci-status $i_branch; done;
}

#
# Aliases
#

alias gbranches='git branch --format="%(refname:short)" | xargs git lg'
alias grebase='git rebase --interactive --autosquash'
alias gamend='git add -A .;git amend;gpush -f'
