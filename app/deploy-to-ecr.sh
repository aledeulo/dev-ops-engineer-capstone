#! /bin/bash -e

IMAGE_NAME=project-ml-kubernetes-$1
AWS_ACCOUNT_ID=$2
VERSION=$3

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:$VERSION $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$IMAGE_NAME:$VERSION
docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$IMAGE_NAME:$VERSION