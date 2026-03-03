🚀 Cloud-Native SRE Platform
Enterprise-Grade CI/CD, Security & Infrastructure Automation

Developed by: John Robles
Role: Cloud / DevOps / SRE Engineer

📌 Executive Summary

This repository implements a production-oriented SRE ecosystem leveraging Infrastructure as Code (IaC), secure federated authentication, and automated delivery pipelines.

The platform automates the full lifecycle of a containerized Node.js application:

Infrastructure provisioning via Terraform

Remote state management in AWS S3

Secure GitHub → AWS authentication using OIDC

Container image build, vulnerability scanning, and versioned publishing to Amazon ECR

The architecture emphasizes:

Idempotency

Security-first CI/CD

Traceability

Infrastructure immutability

🏗 System Architecture

Developer → GitHub Push → GitHub Actions → Terraform (IaC) → Docker Build → Trivy Scan → Amazon ECR

Flow Breakdown

Code pushed to main

GitHub Actions triggers pipeline

Terraform provisions / updates:

Amazon ECR

S3 remote backend

Docker builds image

Trivy scans image for CRITICAL vulnerabilities

Image tagged using commit SHA

Secure push to ECR

🛠 Technical Stack
Category	Technology	Purpose
Cloud	AWS	ECR, S3, IAM
IaC	Terraform	Infrastructure provisioning
Runtime	Node.js / Express	Backend API
Container	Docker	Application packaging
CI/CD	GitHub Actions	Automation pipeline
Security	OIDC + STS	Federated AWS authentication
Security Scan	Trivy	Container vulnerability detection
📂 Project Structure
cloud-native-sre-platform/
├── .github/workflows/
│   └── deploy.yml        # Unified CI/CD pipeline
├── app/                  # Node.js application
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── backend.tf        # S3 remote state backend
├── Dockerfile
└── package.json
🔁 CI/CD Pipeline Design
1️⃣ Infrastructure Stage

terraform init

terraform validate

terraform apply

Capture repository_url as workflow output

Remote state is stored in encrypted S3 backend.

2️⃣ Application & Security Stage

Docker build

Commit-based SHA tagging

Trivy security scan (blocks CRITICAL vulnerabilities)

Secure OIDC authentication with AWS

Push image to ECR

Example image tag:

753675398606.dkr.ecr.us-east-1.amazonaws.com/cloud-native-sre-platform-iac:3cfff2b
🔐 Security Architecture
Federated Identity (OIDC)

Instead of static access keys:

GitHub requests temporary token

AWS STS validates trust policy

Temporary credentials issued

No long-lived secrets stored

Container Hardening

CRITICAL vulnerability blocking enabled

Dependencies regularly updated

Image tagged immutably via commit SHA

IAM Least Privilege

Role permissions scoped strictly to:

ECR push

S3 backend access

🚀 Local Development
Install Dependencies
npm install
Run Application
node app/index.js
Docker Build
docker build -t cloud-native-sre-platform .
docker run -p 3000:3000 cloud-native-sre-platform
📈 Roadmap

✅ Remote S3 Backend
✅ OIDC Federated Authentication
✅ SHA-Based Image Versioning
✅ Trivy Security Scanning

⬜ Terraform Plan Enforcement
⬜ Multi-Environment (dev/prod)
⬜ DynamoDB State Locking
⬜ ECS Fargate Deployment
⬜ Monitoring & Observability

🎯 Demonstrated SRE Concepts

✔ Infrastructure as Code
✔ Remote State Management
✔ Secure Federated Authentication
✔ Immutable Deployments
✔ CI/CD Orchestration
✔ Container Security Enforcement
✔ Image Traceability via SHA

👤 Author

John Robles
Cloud / DevOps / SRE Engineering
Infrastructure Automation | CI/CD | Secure Cloud Architecture
