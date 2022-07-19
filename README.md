[![CircleCI](https://dl.circleci.com/status-badge/img/gh/aledeulo/dev-ops-engineer-capstone/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/aledeulo/dev-ops-engineer-capstone/tree/main)

## Project Overview
This is a simple Hello World application which is going to be deployed on AWS EKS by using circleci to manage the CI/CD process.
I have made uses of circleci orbs to handle the EKS cluster and worker nodes creation, push docker image to ECR repository and deploy the pods into the cluster.

## Deployment strategy:
I have decided to use Rolling update as deployment process bucause EKS in combination with CircleCI orbs make this really easy to apply and configure. 
For this sample I decided to use EKS + NLB to route the traffic into the cluster

## Deployment process
This is explained in a photo called pipeline into the attachments folder

## Deployment env vars required in Circleci
AWS_ACCESS_KEY_ID
AWS_ACCOUNT
AWS_DEFAULT_REGION
AWS_SECRET_ACCESS_KEY
ECR_REPO
ECR_URI
ENV_NAME

### personalized env vars sample
ECR_REPO=uda-capstone-projec
ECR_URI=246528985509.dkr.ecr.us-east-2.amazonaws.com
ENV_NAME=prod


## Attachement folder
This folder contains all the images that has been required to show full deployment status and pipeline design

## Notes
Cluster and resorces are going to be created in Aws us-east-2 because of issues with resources capacity with us-east-1 (default region), and it is also not recommended by AWS to use Virginia as main region to deploy production applications


## Load balancer DNS
a016666a4a00844b8a8e6e36a3c7b777-200803482.us-east-2.elb.amazonaws.com
### Test the app
curl http://a016666a4a00844b8a8e6e36a3c7b777-200803482.us-east-2.elb.amazonaws.com/alive
Expect: Hello, World!
