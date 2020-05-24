#!/bin/bash

# Requires aws-rotate-iam-keys
# Requires gnu-getops 
# brew install gnu-getops

./aws-rotate-iam-keys.sh --profile sandbox
./aws-rotate-iam-keys.sh --profile default

for counter in $(seq -f "%02g" 1 20); do
    echo -e "\n####### Rotating ws$counter \n"
    ./aws-rotate-iam-keys.sh --profile "ws$counter"
done


