"""
Auth: Abhijeet Chopra
Date: 2024-03-15
Desc: This script updates the desired task count for given ECS service in the given AWS account

Usage: python3 update-ecs-desired-task-counts.py --profile <aws-named-profile> --region <aws-region> --config <config-file>

Example: python3 update-ecs-desired-task-counts.py --profile default --region us-east-1 --config task-counts.csv
"""

import argparse
import boto3
import csv
import json
import time

# Create the parser
parser = argparse.ArgumentParser(description='AWS named profile and region')

# Add the arguments
parser.add_argument('--profile', type=str, required=True, help='the aws named profile to use')
parser.add_argument('--region', type=str, required=True, help='the aws region to use')
parser.add_argument('--config', type=str, required=True, help='the config file to use')

# Parse the arguments
args = parser.parse_args()

filename = args.config

# Initialize a list to store the data
data = []

# Open the file and read each line
with open(filename, 'r') as file:
    csv_reader = csv.reader(file)
    for row in csv_reader:
        # Each row is a list of strings
        # Convert it into a dictionary and add it to the data list
        data.append({
            "service_name": row[0],
            "task_count": int(row[1]),
            "cluster_name": row[2]
        })

# Create a session using the named profile
session = boto3.Session(profile_name=args.profile, region_name=args.region)

# Create an ECS resource object using the session
ecs_client = session.client('ecs')

# Print service_name, cluster_name, and task_count for each object
for item in data:
    print(f"\n- {item['service_name']}\n    cluster_name: {item['cluster_name']}\n    task_count: {item['task_count']}\n")
    # Update the desired task count for the service
    response = ecs_client.update_service(
        cluster=item['cluster_name'],
        service=item['service_name'],
        desiredCount=item['task_count']
    )

    # Print the response
    # TODO: pretty print the json response
    #    print(json.dumps(response, indent=4))
    print(response)

    # TODO: add error handling

    # Sleep to avoid rate limiting
    # UpdateService has a burst rate (or bucket maximum capacity) of 50
    # Ref: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/request-throttling.html
    time.sleep(0.02)

# Print a message to indicate that the script has completed
print("\nEnd of script.\n")
