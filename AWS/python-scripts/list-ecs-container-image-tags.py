"""
Auth: Abhijeet Chopra
Date: 2024-03-25
Desc: This script lists the container image tag for all ECS service in the given AWS account

Usage: python3 list-ecs-container-image-tags.py --profile <aws-named-profile> --region <aws-region>

Example: python3 list-ecs-container-image-tags.py --profile default --region us-east-1

Power user: filter out the services you are not interested in using grep, and sort the output using column and sort
  python3 list-ecs-container-image-tags.py --profile default --region us-east-1 | grep -v -e nginx -e datadog -e sumo | column -t -s , | sort -u -k 1 | cat -n
"""

import argparse
import boto3
import json

# Create the parser
parser = argparse.ArgumentParser(description='AWS named profile and region')

# Add the arguments
parser.add_argument('--profile', type=str, required=True, help='the aws named profile to use')
parser.add_argument('--region', type=str, required=True, help='the aws region to use')

# Parse the arguments
args = parser.parse_args()

# Create a session using the named profile
session = boto3.Session(profile_name=args.profile, region_name=args.region)

# Create an ECS resource object using the session
ecs_client = session.client('ecs')

# Get all clusters
clusters = ecs_client.list_clusters()

# For each cluster, list all services
for cluster_arn in clusters['clusterArns']:
    services = ecs_client.list_services(cluster=cluster_arn,maxResults=100)

    # For each service, describe the service and print the image tag
    for service_arn in services['serviceArns']:
        service = ecs_client.describe_services(cluster=cluster_arn, services=[service_arn])
        for serv in service['services']:
            # Get the task definition
            task_definition = ecs_client.describe_task_definition(taskDefinition=serv['taskDefinition'])

            # Extract the image tag from the container definitions
            for container_def in task_definition['taskDefinition']['containerDefinitions']:
                image = container_def['image']
                image_tag = image.split(':')[-1] if ':' in image else 'latest'
                print(f"{service_arn.split('/')[-1]},{container_def['name']},{image_tag}")
