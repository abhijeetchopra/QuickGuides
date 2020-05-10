# QuickGuide | AWS

```aw

# describe vpcs
aws ec2 describe-vpcs --profile $AWS_PROFILE --region=us-east-1 | grep -e "OwnerId" -e "VpcId"

# describe instances
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table

# describe instances with ids
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids $INSERT_INSTANCE_ID

# describe instances filter by instance-id
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids $INSERT_INSTANCE_ID

# iterage over profiles in config file and get vpcs (using grep)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | grep -e 'OwnerId' -e 'VpcId'"; echo "------------------------" ; done;

# iterage over profiles in config file and get vpcs (using jq)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | jq '.' | jq -r '.Vpcs[].VpcId,.Vpcs[].OwnerId'"; echo "------------------------" ; done;

# iterage over profiles in config file and get vpcs (using aws cli --query option
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 'Vpcs[].VpcId,'"; echo "------------------------" ; done;

# list account number / ownerid of instance from given instanceid (using jq)
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --instance-ids $INSERT_INSTANCE_ID | jq -r '.Reservations[].OwnerId'

# list account number / ownerid of instance from given instanceid (using --query option)
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --instance-ids $INSERT_INSTANCE_ID --query 'Reservations[0].OwnerId' --output text

# list account alias from given profile
aws iam list-account-aliases --profile $AWS_PROFILE

# list userid, ownerid, arn
aws sts get-caller-identity

# Retrieves an authorization token that is valid for a 12 hours and executes
#   docker login commands to logs in to your registry with Docker. After you
#   have logged in to an Amazon ECR registry with this command, you can
#   use the Docker CLI to push and pull images from that registry until the token expires.

$(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION --profile $AWS_PROFILE)

# NOTE: the above command works in aws cli v1 and does not work in aws cli v2 as get-login
#       command option is deprecated in future aws cli versions.
#
# REF:  https://docs.aws.amazon.com/cli/latest/userguide/cliv2-migration.html#cliv2-migration-ecr-get-login
#
# FIX:  execute below command in place of above for use with aws cli v2
#
aws ecr get-login-password --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $INSERT_AWS_ACCOUNT_ID.dkr.ecr.$INSERT_AWS_REGION.amazonaws.com

# listing images in repositories

# describe repositories - all
aws ecr describe-repositories --profile $AWS_PROFILE --region=$AWS_DEFAULT_REGION | jq '.'

# describe repositories - given
# using jq
aws ecr describe-repositories --profile $AWS_PROFILE --region=$AWS_DEFAULT_REGION | jq '.' | jq '.repositories[] | select(.repositoryName == "$INSERT_AWS_ECR_REPOSITORY_NAME")'
# using aws cli jmespath query
aws ecr describe-repositories --profile $AWS_PROFILE --region=us-east-1 --query "repositories[?repositoryName=='$INSERT_AWS_ECR_REPOSITORY_NAME']"


# list images in given repository
aws ecr list-images --repository-name $INSERT_AWS_ECR_REPOSITORY_NAME --profile $AWS_PROFILE --region=$AWS_DEFAULT_REGION

# list latest tag of images in given repository
aws ecr list-images --repository-name $INSERT_AWS_ECR_REPOSITORY_NAME --profile $AWS_PROFILE --region=$AWS_DEFAULT_REGION --query 'imageIds[].imageTag|reverse(sort(@))[0]' --output text
```
