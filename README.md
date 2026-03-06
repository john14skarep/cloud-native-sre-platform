🚀 Cloud-Native SRE Platform

Enterprise-Grade CI/CD, Infrastructure as Code & Cloud Deployment

Author: John Robles
Role: Cloud / DevOps / SRE Engineer

📌 Executive Summary

This repository demonstrates a cloud-native DevOps platform implementing secure CI/CD, infrastructure automation, and container orchestration on AWS.

The project automates the complete lifecycle of a containerized Node.js application, including:

Infrastructure provisioning with Terraform

Secure authentication between GitHub and AWS via OIDC

Automated Docker image build and security scanning

Versioned container publishing to Amazon ECR

Deployment to AWS ECS Fargate

External access through an Application Load Balancer

Centralized logging with CloudWatch

The architecture follows modern DevOps and SRE principles:

Infrastructure as Code

Immutable deployments

Federated authentication

Continuous delivery

Observability

🏗 System Architecture
Developer
   ↓
GitHub Push
   ↓
GitHub Actions CI/CD
   ↓
Terraform Infrastructure Provisioning
   ↓
Docker Image Build
   ↓
Trivy Security Scan
   ↓
Amazon ECR
   ↓
AWS ECS Fargate
   ↓
Application Load Balancer
   ↓
CloudWatch Logs
🛠 Technical Stack
Category	Technology	Purpose
Cloud	AWS	Infrastructure platform
IaC	Terraform	Infrastructure provisioning
Runtime	Node.js / Express	Backend service
Containerization	Docker	Application packaging
Container Registry	Amazon ECR	Image storage
Orchestration	ECS Fargate	Container runtime
Networking	Application Load Balancer	Public access
CI/CD	GitHub Actions	Automated pipeline
Security	OIDC + AWS STS	Secretless authentication
Security Scan	Trivy	Container vulnerability scanning
Observability	CloudWatch Logs	Container log monitoring
📂 Project Structure
cloud-native-sre-platform
│
├── .github/workflows/
│   └── deploy.yml          # CI/CD pipeline
│
├── app/                    # Node.js application
│
├── terraform/
│   ├── main.tf
│   ├── ecs.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── environments/
│
├── Dockerfile
└── package.json
🔁 CI/CD Pipeline

The pipeline is triggered on every push to the main branch.

1️⃣ Infrastructure Stage
terraform init
terraform validate
terraform plan
terraform apply

Infrastructure deployed:

Amazon ECR

ECS Cluster

ECS Service

Application Load Balancer

VPC & networking

CloudWatch Log Group

Remote state:

S3 backend
DynamoDB state locking
2️⃣ Application Stage
Docker build
Image tagging using commit SHA
Trivy vulnerability scan
Push to Amazon ECR

Example image:

753675398606.dkr.ecr.us-east-1.amazonaws.com/cloud-native-sre-platform-dev:3cfff2b
3️⃣ Deployment Stage

After pushing the image:

aws ecs update-service --force-new-deployment

This triggers automatic ECS redeployment.

🔐 Security Architecture
Federated Authentication (OIDC)

Instead of static AWS credentials:

GitHub → OIDC token
AWS STS → temporary credentials
Terraform / CI/CD operations

Benefits:

No stored AWS keys

Temporary credentials

Secure identity federation

Container Security

Security implemented through:

Trivy vulnerability scanning

CRITICAL vulnerability detection

Immutable image tagging

Minimal container footprint

📊 Observability

Container logs are automatically sent to:

AWS CloudWatch Logs

Log group:

/ecs/sre-platform

This enables:

Runtime debugging

Operational monitoring

Production visibility

🌐 Live Deployment Example

Example response from the deployed service:

{
  "message": "Cloud Native SRE Platform Running",
  "status": "healthy"
}

The application is deployed behind:

AWS Application Load Balancer
→ ECS Fargate
→ Docker container
🚀 Local Development

Install dependencies

npm install

Run locally

node app/index.js

Docker build

docker build -t cloud-native-platform .
docker run -p 3000:3000 cloud-native-platform
📈 Roadmap

Completed:

Terraform IaC

Remote state (S3 + DynamoDB)

OIDC authentication

Container security scanning

ECS Fargate deployment

Application Load Balancer

CloudWatch logging

CI/CD automation

Potential future improvements:

Blue/Green deployments

Canary deployments

Prometheus / Grafana monitoring

Autoscaling policies

Multi-environment promotion (dev → prod)

🎯 Demonstrated DevOps / SRE Skills

✔ Infrastructure as Code (Terraform)
✔ Secure CI/CD pipelines
✔ OIDC Federated Authentication
✔ Containerized workloads (Docker)
✔ AWS ECS Fargate orchestration
✔ Load balancing and networking
✔ Container security scanning
✔ Observability and centralized logging
✔ Immutable deployments with versioned images

👤 Author

John Robles

Cloud / DevOps / SRE Engineering

Specializing in:

Infrastructure Automation

CI/CD Pipelines

Cloud Architecture

Container Platforms

Secure DevOps Workflows
