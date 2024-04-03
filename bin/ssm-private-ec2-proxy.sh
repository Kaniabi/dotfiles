#!/bin/bash

AWS_PROFILE=${AWS_PROFILE:-'internal'}
AWS_REGION=${AWS_REGION:-'ca-central-1'}
MAX_ITERATION=5
SLEEP_DURATION=5

# Arguments passed from SSH client
HOST=$1
PORT=${2:-22}

echo $HOST

# Start ssm session
aws ssm start-session --target $HOST \
  --document-name AWS-StartSSHSession \
  --parameters portNumber=${PORT} \
  --profile ${AWS_PROFILE} \
  --region ${AWS_REGION}
