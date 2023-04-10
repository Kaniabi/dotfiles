alias dir="ls -la"

function setg () {
  set | ag -H "$@"
}
