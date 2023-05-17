# QuickGuide | AWS

```aw

# list accounts
aws organizations list-accounts --profile $AWS_PROFILE

# describe vpcs
aws ec2 describe-vpcs --profile $AWS_PROFILE --region=us-east-1 | grep -e "OwnerId" -e "VpcId"

# describe instances
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table

# describe instances with ids
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids $INSERT_INSTANCE_ID

# describe instances filter by instance-id
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids $INSERT_INSTANCE_ID

# print aws profile names from aws config
cat .aws/config | grep -v "^#" | grep "^\[profile" | sed 's/\[profile //;s/\]$//'

# iterate over profiles in config file and get vpcs (using grep)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | grep -e 'OwnerId' -e 'VpcId'"; echo "------------------------" ; done;

# iterate over profiles in config file and get vpcs (using jq)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | jq '.' | jq -r '.Vpcs[].VpcId,.Vpcs[].OwnerId'"; echo "------------------------" ; done;

# iterate over profiles in config file and get vpcs (using aws cli --query option
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 --query='Vpcs[].VpcId' --output=text"; echo "------------------------" ; done;

# iterate over aws named profiles and print decrypted ssm parameter string
for i in $(cat .aws/config | grep -v "^#" | grep "^\[profile" | sed 's/\[profile //;s/\]$//' ); do echo "----------"; echo $i; aws --profile $i --region us-east-1 ssm get-parameter --name /sample/password/string  --with-decryption --query "Parameter.Value" --output text; echo ""; done;

# ssm create parameter
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm put-parameter --name "/path/to/param" --value "SAMPLE-SECRET-STRING" --type "SecureString" --tags "Key=purpose,Value=achopra-testing"

# ssm update parameter
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm put-parameter --name "/path/to/param" --value "SAMPLE-SECRET-STRING" --type "SecureString" --overwrite

# ssm list parameter
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm get-parameter --name "/path/to/param" --with-decryption --query="Parameter.Value" --output text

# ssm list parameters recursively by path
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm get-parameters-by-path --path "/" --recursive --query "Parameters[*] | [].[Name,Value]" --output text

# ssm create parameter load from file
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm put-parameter --name "/path/to/param" --value file:///tmp/file.txt --type "SecureString" --tags "Key=purpose,Value=achopra-testing"

# ssm instance connect
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm start-session --target $AWS_INSTANCE_ID

# ssm list active sessions
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm describe-sessions --state Active

# ssm list name of latest ecs supported ami
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended --query "Parameters[].Value" --output text | jq -r '.image_name'

for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo ""; echo "------------------------ $i"; eval "aws ec2 describe-vpcs --profile $i  --region=us-east-1 --query 'Vpcs[].VpcId' --output text | xargs -n 1"; echo "------------------------" ; done;

# ssm list active sessions
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm describe-sessions --state Active --filters "key=Target,value=$INSTANCE_ID" --output table

# ssm list past sessions
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ssm describe-sessions --state History --filters "key=Target,value=$INSTANCE_ID" --output table

# list account number / ownerid of instance from given instanceid (using jq)
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --instance-ids $INSERT_INSTANCE_ID | jq -r '.Reservations[].OwnerId'

# list account number / ownerid of instance from given instanceid (using --query option)
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --instance-ids $INSERT_INSTANCE_ID --query 'Reservations[0].OwnerId' --output text

# create file with list of AMIs
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ec2 describe-images --owners self --query "Images[].ImageId" | grep ami | sed 's/^.*ami/ami/;s/,//;s/"//' > imageids

# share AMIs with account ; UserId = AWS_ACCOUNT_ID = ID of account to share the image with
for i in `cat imageids`; do aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION ec2 modify-image-attribute --image-id $i --launch-permission "Add=[{UserId=$AWS_ACCOUNT_ID}]"; done;

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

# delete ecr image tag; if only one tag exists, it will delete the image
aws ecr batch-delete-image --repository-name <REPO NAME> --image-ids imageTag=<TAG NAME> --profile <PROFILE> --region <REGION>

aws s3 ls

aws s3 ls s3://test-bucket/sample-file.txt

aws s3 cp ~/localfile.txt s3://test-bucket/sample-file-upload.txt


# list all file versions and save in local file
aws --profile $AWS_PROFILE --region=$AWS_DEFAULT_REGION s3api list-object-versions --bucket $INSERT_BUCKET_NAME --prefix $INSERT_FILE_KEY --query "Versions[].VersionId" --output text | xargs -n 1 > s3-file-versions

# read versoinf from local file and download them from s3 to current directory
for i in `cat s3-file-versions`; do echo ***Downloading...$i***; aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION s3api get-object --bucket $INSERT_BUCKET_NAME --key $INSERT_FILE_KEY $i --version-id $i; done;


# test if file exists in s3 bucket
aws s3api head-object --bucket <bucket-name> --key <file-key>


# list latest launch template version of given launch template name
aws ec2 describe-launch-templates --launch-template-names $INSERT_LAUNCH_TEMPLATE_NAME --profile $AWS_PROFILE --query "LaunchTemplates[].LatestVersionNumber" --output text; done;

# retrieve sts creds
aws sts assume-role --role-arn arn:aws:iam::$INSERT_AWS_ACCOUNT_ID:role/$INSERT_AWS_ROLE_NAME --role-session-name=$INSERT_SOME_LABEL --query Credentials.[AccessKeyId,SecretAccessKey,SessionToken] --output text

# decode aws sts encoded error message
aws sts decode-authorization-message --encoded-message $INSERT_ENCODED_MESSAGE --query DecodedMessage --output text --profile $AWS_PROFILE | jq '.'

# find aws resource in vpc that owns the unknown IP address
aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=$INSERT_IP_ADDRESS

# print asg names and desired capacity
aws --profile $AWS_PROFILE --region $AWS_REGION autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*] | [].[AutoScalingGroupName, DesiredCapacity]" --output text

# print list of asgs tagged with a given key-value
aws --profile $AWS_PROFILE --region $AWS_REGION autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[?Tags[?(Key=='$TAG_KEY') && (Value=='$TAG_VALUE')]].AutoScalingGroupName" --output text | xargs -n 1

# modify asg tag
aws --profile $AWS_PROFILE --region $AWS_REGION autoscaling create-or-update-tags --tags ResourceId=$MY_ASG_NAME,ResourceType=auto-scaling-group,Key=$TAG_KEY,Value=$NEW_TAG_VALUE,PropagateAtLaunch=false

# modify multiple asgs tags given file with line separated names of asgs
for i in `cat ~/file-with-names-of-asgs`; do echo -----$i; aws --profile $AWS_PROFILE --region $AWS_REGION autoscaling create-or-update-tags --tags ResourceId=$i,ResourceType=auto-scaling-group,Key=$TAG_KEY,Value=$NEW_TAG_VALUE,PropagateAtLaunch=false;echo ""; done;

# get instance-id from within ec2 instance
curl -s http://169.254.169.254/latest/meta-data/instance-id

# get user-data from within ec2 instance
curl -s http://169.254.169.254/latest/user-data

# list aws organization accounts
aws organizations list-accounts --output text --query 'Accounts[?Status==`ACTIVE`][Status,JoinedTimestamp,Id,Email,Name,Alias]' | sort | cut -f2- | column -t


# associate vpc with private zone of another account

 # get authorization first
aws route53 create-vpc-association-authorization --hosted-zone-id $INSERT_ZONE_ID --vpc VPCRegion=$INSERT_REGION,VPCId=$INSERT_TARGET_VPC_ID --profile $AWS_PROFILE_OF_ACCOUNT_WITH_ZONE

 # then associate vpc with zone
aws route53 associate-vpc-with-hosted-zone --hosted-zone-id $INSERT_ZONE_ID --vpc VPCRegion=$INSERT_REGION,VPCId=$INSERT_TARGET_VPC_ID --profile $AWS_PROFILE_OF_ACCOUNT_WITH_VPC

# list rds engine versions of running instances
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION rds describe-db-instances --query "DBInstances[*] | [].[DBInstanceIdentifier,EngineVersion]" --output text | column -t

# list all route53 record names in given hosted zone
aws --profile $AWS_PROFILE --region $AWS_DEFAULT_REGION route53 list-resource-record-sets --hosted-zone-id $INSERT-HOSTED-ZONE-ID --query="ResourceRecordSets[].Name" --output text | xargs -n 1 | sed 's/\.$//' | sort | cat -n


```
