#!/bin/bash

# This script installs and configures the AWS Load Balancer Controller for managing ingress resources in the EKS cluster.


#Download IAM policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json

# Create IAM policy
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

#Create IAM Role
eksctl create iamserviceaccount \
  --cluster=<your-cluster-name> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve


#DEPLOY ALB CONTROLLER


# Set variables
CLUSTER_NAME="2048-cluster"
REGION="us-east-1"
NAMESPACE="kube-system"
HELM_REPO="eks"
HELM_CHART="aws-load-balancer-controller"


# Add the EKS Helm repository
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

# Install the AWS Load Balancer Controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \ 
  -n kube-system \
  --set clusterName=$CLUSTER_NAME \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=$REGION \
  --set vpcId=$(aws eks describe-cluster --name $CLUSTER_NAME --query "cluster.resourcesVpcConfig.vpcId" --output text) \
  
# Verify that the deployments are running
kubectl get deployment -n kube-system aws-load-balancer-controller