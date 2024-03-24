"""
Auth: Abhijeet Chopra
Date: 2024-01-24
Desc: This script deletes all objects including all versions in the given S3 bucket in the given AWS account.

Usage: python3 empty-s3-bucket.py --profile <aws-named-profile> --region <aws-region> --bucket <s3-bucket-name>

Example: python3 empty-s3-bucket.py --profile default --region us-east-1 --bucket my-bucket-name

"""

import argparse
import boto3
import botocore
import sys

# Create the parser
parser = argparse.ArgumentParser(description='AWS named profile and region')

# Add the arguments
parser.add_argument('--profile', type=str, required=True, help='the aws named profile to use')
parser.add_argument('--region', type=str, required=True, help='the aws region to use')
parser.add_argument('--bucket', type=str, required=True, help='the s3 bucket to use')

# Parse the arguments
args = parser.parse_args()

# Create a session using the named profile
session = boto3.Session(profile_name=args.profile, region_name=args.region)

# Create an S3 client
s3 = session.client('s3')

# List all objects in the bucket
try:
    response = s3.list_objects_v2(Bucket=args.bucket)
except botocore.exceptions.ClientError as e:
    if e.response['Error']['Code'] == 'NoSuchBucket':
        print("ERROR: The specified bucket does not exist. Please check the bucket name and try again. Exiting...")
        sys.exit(1)
    else:
        # If it's a different error, re-raise the exception
        raise

print(response)

# Delete all objects in the bucket
if 'Contents' in response:
    for obj in response['Contents']:
        s3.delete_object(Bucket=args.bucket, Key=obj['Key'])
        print(f"Deleted object: {obj['Key']}")
else:
    print(f"No objects found in bucket: {args.bucket}")

# Get all object versions in the bucket
response = s3.list_object_versions(Bucket=args.bucket)

# Delete all object versions in the bucket
if 'Versions' in response:
    for obj in response['Versions']:
        s3.delete_object(Bucket=args.bucket, Key=obj['Key'], VersionId=obj['VersionId'])
        print(f"Deleted version: {obj['Key']} - {obj['VersionId']}")
else:
    print(f"No versions found in bucket: {args.bucket}")

# Delete all delete markers in the bucket
if 'DeleteMarkers' in response:
    for obj in response['DeleteMarkers']:
        s3.delete_object(Bucket=args.bucket, Key=obj['Key'], VersionId=obj['VersionId'])
        print(f"Deleted delete marker: {obj['Key']} - {obj['VersionId']}")

print(f"Bucket {args.bucket} is now empty.")
