#!/usr/bin/env bash

export ENV_NAME=$1
echo "Received $ENV_NAME"
export SUCCESS=$(aws cloudformation deploy --template-file ../cf-templates/network.yml  \
                --tags project=udapeople  --stack-name "network-stack-$ENV_NAME"    \
                --parameter-overrides EnvironmentName="$ENV_NAME" --profile=$2||default)

echo "$SUCCESS" > ~/result
if grep -E "Successfully created/updated|No changes to deploy" ~/result
then
echo "Successfully created/updated"
exit 0
else
echo "Could not create network stack."
exit 1
fi    