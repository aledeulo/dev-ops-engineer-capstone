#!/usr/bin/env bash

ENV_NAME=$1
AWS_ACCOUNT=$2
VPC=$3
REGION=$4

helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=$ENV_NAME-cluster \
    --set region=$REGION \
    --set vpcId=$VPC \
    --set image.repository=$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/amazon/aws-load-balancer-controller \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller 

kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
kubectl get deployment -n kube-system aws-load-balancer-controller