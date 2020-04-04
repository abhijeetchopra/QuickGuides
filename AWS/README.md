# QuickGuide | AWS

```bash

# describe vpcs
aws ec2 describe-vpcs --profile $AWS_PROFILE --region=us-east-1 | grep -e "OwnerId" -e "VpcId"

# describe instances
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table

# describe instances with ids
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids <insert-instance-id>

# describe instances filter by instance-id
aws ec2 describe-instances --profile $AWS_PROFILE --region=us-east-1 --output=table --instance-ids <insert-instance-id>

# iterage over profiles in config file and get vpcs (using grep)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | grep -e 'OwnerId' -e 'VpcId'"; echo "------------------------" ; done;

# iterage over profiles in config file and get vpcs (using jq)
for i in $(cat .aws/config | grep -v "^#" | grep "\[" | sed 's/\[//;s/\]//'); do echo "";  echo $i; eval "aws ec2 describe-vpcs --profile $i --region=us-east-1 | jq '.' | jq -r '.Vpcs[].VpcId,.Vpcs[].OwnerId'"; echo "------------------------" ; done;

```
