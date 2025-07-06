#!/bin/bash

# Create EKS Cluster
CLUSTER_NAME="2048-cluster"
REGION="us-east-1"

# Create the EKS cluster using eksctl
eksctl create cluster --name $CLUSTER_NAME --region $REGION --fargate

# Output the cluster details
echo "EKS Cluster '$CLUSTER_NAME' created in region '$REGION'."