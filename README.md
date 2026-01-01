# FastAPI on AKS – Azure DevOps Demo Project

This project demonstrates a **complete DevOps workflow** using **FastAPI**, **Docker**, **Kubernetes**, and **Azure DevOps**, designed to run on **Azure Kubernetes Service (AKS)** with a managed **PostgreSQL** backend.

The focus of this project is **DevOps practices**, not application complexity.

---

## Project Goals

- Build a containerized FastAPI application
- Follow DevOps best practices (12-factor app)
- Prepare the app for Kubernetes & AKS
- Enable CI/CD using Azure DevOps
- Use Infrastructure as Code (IaC) for Azure resources
- Stay **Azure Free Tier–friendly**
- Allow full cleanup by deleting a single resource group

---

## Architecture Overview

Git Repository
↓
Azure DevOps Pipeline (CI)
↓
Docker Image
↓
Azure Container Registry (ACR)
↓
Azure Kubernetes Service (AKS)
↓
FastAPI Application
↓
Azure PostgreSQL (Managed)


---

## Application Features

- FastAPI REST API
- `/health` endpoint for Kubernetes probes
- PostgreSQL integration via SQLAlchemy
- Database configuration via environment variables
- No hardcoded infrastructure dependencies

---

##  Docker

Build the image locally:

```bash
docker build -t devops-demo .

Run locally:
docker run -p 8000:8000 devops-demo

http://localhost:8000/docs

## Kubernetes (Local or AKS)

kubectl apply -f k8s/

Check Rsources

kubectl get pods
kubectl get svc


