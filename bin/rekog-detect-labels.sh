#!/bin/bash

BUCKET="dreis-demos"
FILENAME=`basename $1`

aws s3 cp $1 s3://$BUCKET/
aws rekognition detect-labels --image "{ \"S3Object\" : { \"Bucket\" : \"$BUCKET\", \"Name\": \"$FILENAME\" } }" --min-confidence 80
