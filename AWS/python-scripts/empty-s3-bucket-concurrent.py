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
parser.add_argument('--dry-run', action='store_true', help='perform a dry run')

# Parse the arguments
args = parser.parse_args()

# Create a session using the named profile
session = boto3.Session(profile_name=args.profile, region_name=args.region)

# Create an S3 client
s3 = session.client('s3')

# Check if dry run flag is set
if args.dry_run:
    print("Performing dry run. The following objects/versions would be deleted:")
else:
    print("Deleting the following objects/versions:")
    # Delete all objects in the bucket
    for obj in response['Contents']:
        if args.dry_run:
            print(f"Object to be deleted: {obj['Key']}")
        else:
            s3.delete_object(Bucket=args.bucket, Key=obj['Key'])
            print(f"Deleted object: {obj['Key']}")
    else:
        print(f"No objects found in bucket: {args.bucket}")

# Get all object versions in the bucket
response = s3.list_object_versions(Bucket=args.bucket)
# Delete all object versions in the bucket
if 'Versions' in response:
    for obj in response['Versions']:
        if args.dry_run:
            print(f"Version to be deleted: {obj['Key']} - {obj['VersionId']}")
        else:
            s3.delete_object(Bucket=args.bucket, Key=obj['Key'], VersionId=obj['VersionId'])
            print(f"Deleted version: {obj['Key']} - {obj['VersionId']}")
    print(f"No versions found in bucket: {args.bucket}")

# Delete all delete markers in the bucket
if 'DeleteMarkers' in response:
    for obj in response['DeleteMarkers']:
        if args.dry_run:
            print(f"Delete marker to be deleted: {obj['Key']} - {obj['VersionId']}")
        else:
            s3.delete_object(Bucket=args.bucket, Key=obj['Key'], VersionId=obj['VersionId'])
            print(f"Deleted delete marker: {obj['Key']} - {obj['VersionId']}")
else:
    print(f"No delete markers found in bucket: {args.bucket}")

print(f"Bucket {args.bucket} is now empty.")
