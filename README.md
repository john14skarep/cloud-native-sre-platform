🚀 Cloud Native SRE Platform – CI/CD with Docker & AWS ECR
📌 Overview

This project demonstrates a cloud-native CI/CD workflow using:

Node.js application

Docker containerization

GitHub Actions for CI

AWS ECR for container registry

IAM secure credential management

The goal of this project is to simulate a real DevOps/SRE workflow where application changes automatically build and push container images to a cloud registry.

🏗 Architecture
Developer → GitHub Push → GitHub Actions → Docker Build → AWS ECR
🛠 Tech Stack

Node.js

Docker

GitHub Actions

AWS ECR

IAM

Linux-based runners

🔁 CI/CD Workflow

On every push to main:

GitHub Actions runs

Docker image is built

Image is tagged

Secure login to AWS ECR

Image is pushed automatically

🧪 Endpoints

/ → Application running

/health → Health check endpoint

📦 Run Locally
npm install
node index.js

Or with Docker:

docker build -t cloud-native-sre-platform .
docker run -p 3000:3000 cloud-native-sre-platform
🔐 Security

AWS credentials stored as GitHub Secrets

IAM user with restricted ECR permissions

No hardcoded credentials

📈 Future Improvements

Deploy to AWS ECS

Implement Terraform IaC

Add image versioning with commit SHA

Add security scanning

Add monitoring integration.
