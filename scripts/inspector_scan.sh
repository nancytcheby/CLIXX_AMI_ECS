#!/bin/bash

# Get the latest AMI built by Packer
AMI_ID=$(aws ec2 describe-images \
    --owners self \
    --filters "Name=name,Values=ami-stack-14-ecs-*" \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text \
    --region us-east-1)

echo "Scanning AMI: $AMI_ID"

# Run Inspector2 scan
aws inspector2 list-findings \
    --filter-criteria '{"resourceType":[{"comparison":"EQUALS","value":"AWS_EC2_INSTANCE"}]}' \
    --region us-east-1

echo "Inspector2 scan complete for AMI: $AMI_ID"