function awsin () {
  aws sso login --profile=$1
}

function awsout () {
  aws sso logout --profile=$1
}
