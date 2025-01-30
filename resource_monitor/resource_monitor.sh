#!/bin/bash

set -x  # Enable debugging

# Define a user-writable directory
LOG_DIR="$HOME/resource_monitor"
mkdir -p "$LOG_DIR"  # Create the directory if it doesn't exist

# Define the output file
OUTPUT_FILE="$LOG_DIR/resource_report_$(date +%F).txt"

# Run AWS commands and save output
echo "AWS Resources Report - $(date)" > "$OUTPUT_FILE"
echo "===============================" >> "$OUTPUT_FILE"

echo -e "\nS3 Buckets:" >> "$OUTPUT_FILE"
aws s3 ls >> "$OUTPUT_FILE"

echo -e "\nLambda Functions:" >> "$OUTPUT_FILE"
aws lambda list-functions >> "$OUTPUT_FILE"

echo -e "\nEC2 Instances:" >> "$OUTPUT_FILE"
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId' >> "$OUTPUT_FILE"

echo -e "\nIAM Users:" >> "$OUTPUT_FILE"
aws iam list-users | jq -r '.Users[].UserName' >> "$OUTPUT_FILE"

# Send email (Replace with actual email)
mail -s "Daily AWS Resource Report - $(date +%F) this mail is  from ubuntu server" satyakolli6@gmail.com < "$OUTPUT_FILE"

