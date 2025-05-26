# AWS CLI and friends

if ( $IS_MAC ); then
  INSTALL_CMD aws awscli
  export PATH=$PATH:/usr/local/sessionmanagerplugin/bin
else
  INSTALL_CMD aws "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  # NOTE: Not working in remote dev.
  INSTALL_CMD session-manager-plugin "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
  # INSTALL_CMD sam "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
  # INSTALL_CMD ecs-cli "https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest"
fi

# Aliases

function awsin () {
  aws sso login --profile=$1
}

function awsout () {
  aws sso logout --profile=$1
}

function awsecr () {
  aws --profile mi-shared ecr get-login-password | docker login -u AWS --password-stdin "https://050946403637.dkr.ecr.ca-central-1.amazonaws.com"
}

function aws.role_last_used () {
  profile=$1;shift
  i_role=$1;shift
  last_used=$(aws iam get-role --profile $profile --role-name $i_role --query 'Role.RoleLastUsed.LastUsedDate' --output text 2>/dev/null)
  if [[ "$last_used" != "None" && -n "$last_used" ]]; then
    last_used_epoch=$(date -d "$last_used" +"%s")
    now_epoch=$(date +"%s")
    echo $(( (now_epoch - last_used_epoch) / 86400 ))
  else
    echo 9999
  fi
}

function aws.delete_role () {
  local profile=$1;shift
  local role=$1;shift
  local policies="$(aws iam list-attached-role-policies --profile $profile --role-name $role --query 'AttachedPolicies[].PolicyArn' --output text || continue)"
  if [[ "$policies" ]]; then
    for j_policy in "${policies[@]}"; do
      aws iam detach-role-policy --profile $profile --role-name $role --policy-arn $j_policy;
    done
  fi
  policies="$(aws iam list-role-policies --profile $profile --role-name $role --query 'PolicyNames' --output text || continue)"
  if [[ "$policies" ]]; then
    for j_policy in "${policies[@]}"; do
      aws iam delete-role-policy --profile $profile --role-name $role --policy-name $j_policy;
    done
  fi
  aws iam delete-role --profile $profile --role-name $role
}

function aws.delete_roles () {
  local profile=$1;shift
  local profile_roles=$(aws iam list-roles --profile $profile --query "Roles[?RoleName!='aws-service-role/' && !starts_with(RoleName, 'AWSServiceRoleFor')].RoleName" --output text | tr '\n' ' ')
  for i_role in "${=@}"; do
    if [[ ! "$profile_roles" =~ "$i_role" ]]; then
      continue
    fi

    days_ago=$(aws.role_last_used $profile $i_role)

    # if [[ "$days_ago" -lt 120 ]]; then
    #  echo "SKIP   $profile:$i_role:$days_ago"
    #  continue
    # fi

    echo "DELETE $profile:$i_role:$days_ago"
    aws.delete_role $profile $i_role
  done
}

function aws.list_roles () {
  local profiles="${@:-$(aws --output text configure list-profiles | tr '\n' ' ')}"
  for i_profile in ${=profiles[@]}; do
    profile_roles=$(aws iam list-roles --profile $i_profile --query "Roles[?RoleName!='aws-service-role/' && !starts_with(RoleName, 'AWSServiceRoleFor')].RoleName" --output text | tr '\n' ' ')
    for j_role in "${=profile_roles}"; do
      if [[ "$j_role" =~ "as24-" || "$j_role" =~ "StackSet-" || "$j_role" == "" ]]; then
        continue
      fi
      days_ago=$(aws.role_last_used $i_profile $j_role)
      echo "$i_profile:$j_role:$days_ago"
    done
  done
}

# export ROLES_TO_DELETE="Temp-cross-account-role-tocheck-secrets-manager-in-aft mi-dev-deployer mi-qa-deployer mi-prod-deployer LaravelVapor mi-uat-deployer OrganizationAccountAccessRole tr-infra-deployment-role trader-managed-ec2-role mi-uat-deployer AWSAFTExecution aft-codebuild-customizations-role tdr-autosync-ecs-task-execution-role trader-managed-ec2-role"
export ROLES_TO_DELETE="axonius-adapter-role OrganizationAccountAccessRole tr-infra-deployment-role AWSAFTExecution AWSAFTService AWSControlTowerExecution"
