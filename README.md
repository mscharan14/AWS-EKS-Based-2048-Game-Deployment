# AWS EKS Based 2048 Game Deployment

## Overview

This project demonstrates the end-to-end deployment of a 2048 game application on AWS EKS using Fargate, Ingress, and ALB, showcasing a scalable and publicly accessible Kubernetes architecture.

## Prerequisites

- AWS CLI installed and configured
- eksctl installed
- kubectl installed
- Helm installed

## Setup Steps

1. **Create EKS Cluster**

   Run the following command to create the EKS cluster:

   ```
   ./scripts/create-cluster.sh
   ```

2. **Configure OIDC Provider**

   Execute the script to configure the IAM OIDC provider:

   ```
   ./scripts/configure-oidc.sh
   ```

3. **Setup ALB Controller**

   Install and configure the AWS Load Balancer Controller:

   ```
   ./scripts/setup-alb-controller.sh
   ```

4. **Create Fargate Profile**

   Apply the Fargate profile configuration:

   ```
   kubectl apply -f manifests/fargate-profile.yml
   ```

5. **Deploy the Application**

   Deploy the application using the deployment and service manifests:

   ```
   kubectl apply -f manifests/deployment.yml
   kubectl apply -f manifests/service.yml
   ```

6. **Setup Ingress**

   Apply the ingress configuration to expose the application:

   ```
   kubectl apply -f manifests/ingress.yml
   ```

7. **Access the Application**

   After the ingress is set up, you can access the 2048 game application using the ALB URL provided in the AWS console.

   ![Preview](./Application-Preview.png)


9. **Delete the Cluster (Optional)**

   If you want to delete the EKS cluster, run:

   ```
   ./scripts/delete-cluster.sh
   ```

## Conclusion

This repository provides a complete workflow for deploying a 2048 game application on AWS EKS. Follow the steps outlined above to set up your environment and deploy the application seamlessly.
