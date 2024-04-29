
#!/bin/bash
set -e

sudo -s

# Install kubectl
curl -LO https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Configure kubeconfig to connect to your sKubernetes cluster
aws eks --region eu-north-1 update-kubeconfig --name eks

cd cd k8s
kubectl apply -f ghcr-secret.yaml
kubectl apply -f 1-mongodb-deployment-green.yaml
kubectl apply -f 1-mongodb-service-green.yaml 
kubectl apply -f 2-rabbitmq-deployment-green.yaml
kubectl apply -f 2-rabbitmq-service-green.yaml 
kubectl apply -f 3-customer-deployment-green.yaml
kubectl apply -f 3-customer-service-green.yaml 
kubectl apply -f 4-products-deployment-green.yaml
kubectl apply -f 4-products-service-green.yaml 
kubectl apply -f 5-shopping-deployment-green.yaml
kubectl apply -f 5-shopping-service-green.yaml 
kubectl apply -f app-green.yaml
kubectl apply -f ingress.yaml