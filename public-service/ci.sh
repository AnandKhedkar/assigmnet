#!/bin/bash

# while getopts ":v:p:" opt; do
#   case ${opt} in
#     v ) version=$OPTARG;;
#     p ) param=$OPTARG;;
#     \? ) echo "Usage: cmd [-v] [-p]";;
#   esac
# done
set -e
cd ../public-service
eval "$(jq -r '@sh "version=\(.version)"')"
doc
docker build -t public-service-package:$version .
echo $version > version
docker tag public-service-package:$version public.ecr.aws/t3o5y1z6/public-service:$version > /dev/null
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/t3o5y1z6 > /dev/null
docker push public.ecr.aws/t3o5y1z6/public-service:$version > /dev/null

echo '{"success": "true"}' | jq .