#!/bin/bash

# exit on any non-zero
set -e

# log output
exec &>>"/var/log/k8s-the-hard-way/apply-cluster-config.log"

echo "----------------"
date
echo "Applying cluster config"

cd /root/

echo "Applying kube-apiserver-to-kubelet.yaml..."
kubectl apply -f kube-apiserver-to-kubelet.yaml --kubeconfig admin.kubeconfig

touch cluster-config-applied

echo
echo "Applying cluster config complete"