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

   ```
   eksctl create fargateprofile \
    --cluster demo-cluster \
    --region us-east-1 \
    --name alb-sample-app \
    --namespace game-2048
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
   
7. **Verify the deployment**

   Check that all pods, services, and the Ingress are properly deployed:

   ```
   kubectl get all -n game-2048
   kubectl get ingress -n game-2048
   ```

8. **Access the Application**

   After a few minutes, the ALB URL will be provisioned. Get it via:
   
   ```
   kubectl get ingress -n game-2048
   ```
   
   You should see an Ingress entry with a valid external ALB hostname. Open the ADDRESS field in a browser to play 2048.

   ![Preview](./Application-Preview.png)


9. **Delete the Cluster (Optional)**

   If you want to delete the EKS cluster, run:

   ```
   ./scripts/delete-cluster.sh
   ```
   
## Skills Demonstrated

This project highlights practical skills across Kubernetes, AWS, and DevOps workflows:

- **Amazon EKS (Elastic Kubernetes Service)** – Managed Kubernetes with scalable and highly available control plane.
- **AWS Fargate** – Serverless compute for Kubernetes Pods without managing EC2 nodes.
- **Kubernetes Core Resources** – Hands-on with Deployments, Services, Namespaces, and Ingress.
- **ALB Ingress Controller** – Configured to route external traffic to Kubernetes services via AWS Application Load Balancer.
- **IAM & OIDC Integration** – Securely attached IAM policies to Kubernetes service accounts using OpenID Connect.
- **Helm Package Management** – Used for deploying the ALB Controller in the EKS cluster.
- **Shell Scripting** – Automation through modular bash scripts to simplify provisioning and cleanup.

## Conclusion

This repository provides a complete workflow for deploying a 2048 game application on AWS EKS. Follow the steps outlined above to set up your environment and deploy the application seamlessly.
