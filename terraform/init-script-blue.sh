#!/bin/bash

set -e
# Install kubectl
curl -LO https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Configure kubeconfig to connect to your Kubernetes cluster
aws eks --region eu-north-1 update-kubeconfig --name eks

cd k8s
echo
kubectl apply -f ghcr-secret.yaml
kubectl apply -f 1-mongodb-deployment-blue.yaml
kubectl apply -f 1-mongodb-service-blue.yaml 
kubectl apply -f 2-rabbitmq-deployment-blue.yaml
kubectl apply -f 2-rabbitmq-service-blue.yaml 
kubectl apply -f 3-customer-deployment-blue.yaml
kubectl apply -f 3-customer-service-blue.yaml 
kubectl apply -f 4-products-deployment-blue.yaml
kubectl apply -f 4-products-service-blue.yaml 
kubectl apply -f 5-shopping-deployment-blue.yaml
kubectl apply -f 5-shopping-service-blue.yaml 
kubectl apply -f app-blue.yaml
kubectl apply -f ingress.yaml
