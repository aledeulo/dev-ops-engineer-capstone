#!/usr/bin/env bash

export ENV_NAME=$1
export ROLE_NAME=$2
export AWS_ACCOUNT=$3

#Configure the cluster
aws eks update-kubeconfig --name $ENV_NAME-cluster --region us-east-1

curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.2/docs/install/iam_policy.json
# Create a policy
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
# Policy attachment to a role
aws iam attach-role-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT:policy/AWSLoadBalancerControllerIAMPolicy --role-name $ROLE_NAME

eksctl create iamserviceaccount \
    --cluster=$ENV_NAME-cluster \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --role-name $ROLE_NAME \
    --attach-policy-arn=arn:aws:iam::$AWS_ACCOUNT:policy/AWSLoadBalancerControllerIAMPolicy \
    --approve 