#!/usr/bin/env bash

ENV_NAME=$1
REGION=$2
#Deploy the cluster if not exist
eksctl create cluster \
    --name $ENV_NAME-cluster \
    --version 1.19 \
    --region $REGION \
    --nodegroup-name $ENV_NAME-worker \
    --node-type t3.medium \
    --nodes 2 \
    --nodes-min 2 \
    --nodes-max 3 \
    --node-volume-size 20 \
    --ssh-access \    
    --ssh-public-key DEFAULT_EKS_US_EAST_2_Key \
    --managed \
    --asg-access \
    --external-dns-access \
    --full-ecr-access \
    --appmesh-access \
    --alb-ingress-access \
    --verbose 3