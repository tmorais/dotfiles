#!/bin/bash

echo "$S3_UPSIGN_TEMP_BUCKET"

if [ -z ${S3_UPSIGN_TEMP_BUCKET+x} ]; then 
    echo "var S3_UPSIGN_TEMP_BUCKET is unset. Please, include it on your .bash_profile or S3_UPSIGN_TEMP_BUCKET=\"s3://temp\" $0"; 
    exit 1;
else 
    echo "S3_UPSIGN_TEMP_BUCKET is set to '$S3_UPSIGN_TEMP_BUCKET'"; 
fi

if [ -z ${S3_UPSIGN_EXPIRES_IN+x} ]; then 
    echo "var S3_UPSIGN_EXPIRES_IN is unset. Using one week as default."; 
    S3_UPSIGN_EXPIRES_IN="3600*24*7"
else 
    echo "S3_UPSIGN_EXPIRES_IN is set to '$S3_UPSIGN_EXPIRES_IN'"; 
fi

FILENAME=$(basename $1)

echo "S3 upsigning $1..."
echo "Destination $S3_UPSIGN_TEMP_BUCKET/$FILENAME..."

aws s3 cp "$1" "$S3_UPSIGN_TEMP_BUCKET"
if [ $? -ne 0 ]; then
    echo "ERROR: Check your AWS PROFILE"
    exit
fi

SIGNED_URL=`aws s3 presign "$S3_UPSIGN_TEMP_BUCKET/$FILENAME" \
    --expires-in $(echo $S3_UPSIGN_EXPIRES_IN | bc -l)`

echo -e "S3 signed URL...\n\n$SIGNED_URL\n\n"
