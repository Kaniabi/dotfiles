alias dir="ls -la"
alias ag="\ag --hidden"

function setg () {
  set | ag -H "$@"
}
