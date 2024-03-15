function za () {
  zops anatomy apply ${1:-.}
  terraform fmt ${1:-.}
}
