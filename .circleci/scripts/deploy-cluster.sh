#!/usr/bin/env bash

ENV_NAME=$1
echo "Received $ENV_NAME"

VALIDATE=$(aws eks describe-cluster --name $ENV_NAME-cluster --profile ale-udacity --query 'cluster.name')
echo "$VALIDATE" > ~/validate
if cat ~/validate | grep "$ENV_NAME-cluster"
then
    echo "Cluster $ENV_NAME-cluster already exist."
    exit 0
else
    echo "Attempting to create the cluster $ENV_NAME-cluster"
fi

SG=$(aws cloudformation list-exports --query "Exports[?Name==\`$ENV_NAME-SecurityGroups\`].Value" \
             --no-paginate --output text  --profile=$2||default)

echo "Received SG: $SG"

SUBNETS=$(aws cloudformation list-exports --query "Exports[?Name==\`$ENV_NAME-SubnetIds\`].Value" \
            --no-paginate --output text  --profile=$2||default)

echo "Received Subnets: $SUBNETS"

aws eks create-cluster --name $ENV_NAME-cluster \
                --role-arn arn:aws:iam::246528985509:role/UdaEKSClusterAccess \
                --resources-vpc-config subnetIds=$SUBNETS,securityGroupIds=$SG \
                --profile=$2||default --region us-east-1 


aws eks wait cluster-active --name $ENV_NAME-cluster --profile=$2||default