#!/bin/bash

set -e

echo "🚀 Starting Kubernetes stack (k8s-dev)..."

# =========================
# 1. Install Ingress Controller FIRST (if not exists)
# =========================
echo "📦 Installing ingress-nginx controller..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml

# Wait for ingress to be ready (optional but useful)
echo "⏳ Waiting for ingress-nginx to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pods \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s || true

# =========================
# 2. Your cluster resources
# =========================
kubectl apply -f cluster/
kubectl apply -f config/
kubectl apply -f databases/mysql/
kubectl apply -f services/auth/
kubectl apply -f services/api/
kubectl apply -f tools/adminer/

echo "✅ All resources deployed"

kubectl get pods -n k8s-dev