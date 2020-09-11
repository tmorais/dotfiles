#!/bin/bash

if [ -z ${REKOG_INDEX_TEMP_BUCKET+x} ]; then 
    echo "var REKOG_INDEX_TEMP_BUCKET is unset. Please, include it on your .bashrc or REKOG_INDEX_TEMP_BUCKET=\"s3://temp\" $0"; 
    exit 1;
else 
    echo "REKOG_INDEX_TEMP_BUCKET is set to '$REKOG_INDEX_TEMP_BUCKET'"; 
fi

if [ -z ${REKOG_INDEX_DEFAULT_COLLECTION+x} ]; then 
    echo "var REKOG_INDEX_DEFAULT_COLLECTION is unset. Please, include it on your .bashrc or REKOG_INDEX_DEFAULT_COLLECTION=\"temp\" $0"; 
    exit 1;
else 
    echo "REKOG_INDEX_DEFAULT_COLLECTION is set to '$REKOG_INDEX_DEFAULT_COLLECTION'"; 
fi

if [ -z ${1} ]; then 
    echo "No input file."; 
    exit 1;
fi

FILENAME=`basename $1`

aws s3 cp "$1" "s3://$REKOG_INDEX_TEMP_BUCKET/"

aws rekognition index-faces \
    --image "{ \"S3Object\" : { \"Bucket\" : \"$REKOG_INDEX_TEMP_BUCKET\", \"Name\": \"$FILENAME\" } }" \
    --collection-id "$REKOG_INDEX_DEFAULT_COLLECTION" \
    --max-faces 5 \
    --quality-filter "HIGH" \
    --detection-attributes "ALL" \
    --external-image-id "$1" \
    --region "us-east-1"

aws s3 rm "s3://$REKOG_INDEX_TEMP_BUCKET/$1"
