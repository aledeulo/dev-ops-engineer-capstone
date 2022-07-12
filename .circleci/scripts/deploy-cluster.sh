#!/usr/bin/env bash

ENV_NAME=$1

#Verify if the cluster already exist cluster
VALIDATE=$(aws eks describe-cluster --name $ENV_NAME-cluster --query 'cluster.name')
echo "$VALIDATE" > ~/validate
if cat ~/validate | grep "$ENV_NAME-cluster"
then
    echo "Cluster $ENV_NAME-cluster already exist."
    exit 0
else
    echo "Attempting to create the cluster $ENV_NAME-cluster"
fi

#Deploy the cluster if not exist

PUBLIC_SUBNETS=$(aws cloudformation list-exports --query "Exports[?Name==\`$ENV_NAME-PUB-NETS\`].Value" \
                          --no-paginate --output text)

echo "Received PUBLIC_SUBNETS: $PUBLIC_SUBNETS"

PRIVATE_SUBNETS=$(aws cloudformation list-exports --query "Exports[?Name==\`$ENV_NAME-PRIV-NETS\`].Value" \
                    --no-paginate --output text)

echo "Received PRIVATE_SUBNETS: $PRIVATE_SUBNETS"

eksctl create cluster \
    --name $ENV_NAME-cluster \
    --version 1.19
    --vpc-private-subnets=$PRIVATE_SUBNETS \
    --vpc-public-subnets=$PUBLIC_SUBNETS \
    --region us-east-1 \
    --nodegroup-name $ENV_NAME-worker \
    --node-type t2.micro \
    --nodes 2 \
    --nodes-min 1 \
    --node-max 3 \
    --ssh-access \
    --node-volume-size 8 \
    --ssh-public-key Default_EKS_Access_Key \
    --appmesh-access \
    --full-ecr-access \
    --alb-ingress-access \
    --managed \
    --asg-access \
    --verbose 3
