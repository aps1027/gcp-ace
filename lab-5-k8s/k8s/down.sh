#!/bin/bash

set -e

echo "🧨 Stopping Kubernetes stack..."

# Delete your app namespace (this removes EVERYTHING inside)
kubectl delete namespace k8s-dev || true

# OPTIONAL: remove ingress-nginx completely
# kubectl delete namespace ingress-nginx || true

echo "✅ All resources removed"