# 📑 Lab 2: GKE Operations & Managed Scaling

<strong>Goal:</strong> Deploy a production-ready GKE Autopilot cluster and practice zero-downtime rollbacks.

## 🎯 Exam Objectives Covered

- <strong>Domain 3.2:</strong> Deploying and Implementing GKE Clusters (Autopilot vs. Standard).
- <strong>Domain 4.1:</strong> Managing GKE Resources (Deployments, Services, Pods).
- <strong>Domain 4.2:</strong> Troubleshooting GKE (Rollouts, ImagePullBackOff).
- <strong>Domain 5.2:</strong> Configuring Private Clusters (Question 33).

## Deploying with Terraform

```bash
terraform apply
```

### The Final Test: Private Google Access

## Connect to your Cluster

```bash
gcloud container clusters get-credentials ace-autopilot-cluster --region us-central1
```

## Simulate a "Bad Update"

```bash
kubectl set image deployment/web-server nginx=nginx:broken-typo
```

## Check what is happening to your Pods

```bash
kubectl get pods
```

## The Emergency Rollback

```bash
kubectl rollout undo deployment/web-server
```

## Cleanup

```bash
terraform destroy
```
