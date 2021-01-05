#!/bin/bash

if [ -z ${S3_UPSIGN_AWS_PROFILE+x} ]; then 
    echo "EEE S3_UPSIGN_AWS_PROFILE is unset."; 
    exit 2
else 
    echo "+++ S3_UPSIGN_AWS_PROFILE = '$S3_UPSIGN_AWS_PROFILE'"; 
fi

if [ -z ${S3_UPSIGN_TEMP_BUCKET+x} ]; then 
    echo "EEE S3_UPSIGN_TEMP_BUCKET is unset. Please, include it on your .bash_profile or S3_UPSIGN_TEMP_BUCKET=\"s3://temp\" $0"; 
    exit 1;
else 
    echo "+++ S3_UPSIGN_TEMP_BUCKET = '$S3_UPSIGN_TEMP_BUCKET'"; 
fi

if [ -z ${S3_UPSIGN_EXPIRES_IN+x} ]; then 
    echo "!!! S3_UPSIGN_EXPIRES_IN is unset. Using one week as default."; 
    S3_UPSIGN_EXPIRES_IN="3600*24*7"
else 
    echo "+++ S3_UPSIGN_EXPIRES_IN = '$S3_UPSIGN_EXPIRES_IN'"; 
fi

FILENAME=$(basename $1)

echo -e "\nS3 upsigning $1..."
echo -e "\nDestination $S3_UPSIGN_TEMP_BUCKET/$FILENAME..."

aws s3 cp "$1" "$S3_UPSIGN_TEMP_BUCKET" \
    --acl private \
    --profile "$S3_UPSIGN_AWS_PROFILE"

if [ $? -ne 0 ]; then
    echo "EEE Check your AWS PROFILE"
    exit
fi

SIGNED_URL=`aws s3 presign "$S3_UPSIGN_TEMP_BUCKET/$FILENAME" \
    --expires-in $(echo $S3_UPSIGN_EXPIRES_IN | bc -l) \
    --profile "$S3_UPSIGN_AWS_PROFILE"`

echo -e "S3 signed URL...\n\n$SIGNED_URL\n\n"
