# DevOps CI/CD Demo – Azure DevOps, Docker & AKS

## Overview
This project demonstrates an end-to-end DevOps workflow using Azure DevOps CI/CD pipelines to build, containerize, and deploy a Python FastAPI application to Azure Kubernetes Service (AKS).

The goal of this project is to showcase modern DevOps practices such as CI/CD automation, containerization, Kubernetes deployments, and secure configuration management.

## Architecture
- Source Code: GitHub
- CI/CD: Azure DevOps Pipelines
- Container Registry: Azure Container Registry (ACR)
- Orchestration: Azure Kubernetes Service (AKS)
- Application: FastAPI (Python)

## Technology Stack
- Python (FastAPI)
- Docker
- Azure DevOps Pipelines (YAML)
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS)
- Kubernetes (Deployments, Services)
- Git

## CI/CD Pipeline Flow
1. Code commit to GitHub repository
2. Azure DevOps pipeline triggered
3. Application build and unit validation
4. Docker image build
5. Image pushed to Azure Container Registry
6. Kubernetes manifests applied to AKS
7. Application deployed with rolling updates

## Kubernetes Deployment
- Deployment with replica management
- Service for application exposure
- Environment-based configuration using ConfigMaps
- Secrets managed securely (placeholders)

## How to Run Locally
```bash
pip install -r requirements.txt
uvicorn app.main:app --reload
