#!/bin/bash

# Set the cluster name
export cluster_name=2048-cluster

# Get the OIDC ID from the EKS cluster
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)

# Check if there is an IAM OIDC provider configured already
if ! aws iam list-open-id-connect-providers | grep -q $oidc_id; then
    eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
else
    echo "OIDC provider is already configured."
fi