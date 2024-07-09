#!/bin/bash

AWS_PROFILE=${AWS_PROFILE:-'mi-is'}
AWS_REGION=${AWS_REGION:-'ca-central-1'}
MAX_ITERATION=5
SLEEP_DURATION=5

# Arguments passed from SSH client
HOST=$1;shift
if [[ -n $1 ]]; then
  PORT=${1};shift
else
  PORT=22
fi

echo $HOST

# Start ssm session
export PATH=$PATH:/usr/local/bin
aws ssm start-session --target $HOST \
  --document-name AWS-StartSSHSession \
  --parameters portNumber=${PORT} \
  --profile ${AWS_PROFILE} \
  --region ${AWS_REGION}
