#!/usr/bin/env bash

ENV_NAME=$1
#Deploy the cluster if not exist
eksctl create cluster \
    --name $ENV_NAME-cluster \
    --version 1.19 \
    --region us-east-1 \  
    # --zones us-east-1a,us-east-1b,us-east-1c \  
    --nodegroup-name $ENV_NAME-worker \
    --node-type t3.medium \
    --nodes 2 \
    --nodes-min 1 \
    --nodes-max 3 \
    --ssh-access \
    --node-volume-size 20 \
    --ssh-public-key Default_EKS_Access_Key \
    --appmesh-access \
    --full-ecr-access \
    --alb-ingress-access \
    --managed \
    --asg-access \
    --verbose 3 \