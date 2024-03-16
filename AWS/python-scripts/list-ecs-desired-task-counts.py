"""
Auth: Abhijeet Chopra
Date: 2024-01-24
Desc: This script lists the desired task count for all ECS service in all ECS clusters in the given AWS account

Usage: python3 list-ecs-desired-task-counts.py --profile <aws-named-profile> --region <aws-region>

Example: python3 list-ecs-desired-task-counts.py --profile default --region us-east-1

To save the output to a file to be read by the update-ecs-desired-task-counts.py script, use the following command:
         python3 list-ecs-desired-task-counts.py --profile default --region us-east-1 > sort -u > task-counts.csv
"""

import argparse
import boto3

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

    # For each service, describe the service and print the desired task count
    for service_arn in services['serviceArns']:
        service = ecs_client.describe_services(cluster=cluster_arn, services=[service_arn])
        for serv in service['services']:
            print(f"{serv['serviceName']},{serv['desiredCount']},{cluster_arn.split('/')[-1]}")
