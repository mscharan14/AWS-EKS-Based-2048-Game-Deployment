#!/bin/bash

# Delete the EKS cluster
eksctl delete cluster --name 2048-cluster --region us-east-1

# Optionally, you can add a confirmation prompt
echo "EKS cluster '2048-cluster' has been deleted."