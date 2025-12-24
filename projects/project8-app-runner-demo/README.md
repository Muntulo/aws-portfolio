# Project 8 – Containerized Serverless API with AWS App Runner

## Overview
Deployed a fully managed, containerized web API using AWS App Runner — the modern way to run Docker containers without managing servers, load balancers, or scaling infrastructure.

This project demonstrates containerized serverless deployment, bridging traditional EC2-based apps and pure serverless functions.

**Key AWS Services**
- **AWS App Runner** – Fully managed container hosting (auto-scaling, HTTPS, health checks)
- **Amazon ECR** – Private Docker image registry
- **Docker** – Containerization of a Node.js/Express API

**Live Demo**
https://exx24tmpap.us-east-1.awsapprunner.com – Simple "Hello" API with health endpoint

## Architecture Highlights
- No EC2 instances, no VPC, no ALB — App Runner handles everything
- Docker container built locally and pushed to ECR
- Automatic HTTPS with managed certificate
- Built-in health checks and auto-scaling
- Zero server management — pure serverless containers

## Screenshots
- `docker-build-success.png` – Local Docker build output
- `docker-local-test.png` – Local container test in browser
- `ecr-repo-created.png` – ECR repository with image URI
- `ecr-push-success.png` – Successful Docker push to ECR
- `app-runner-domain-working.png` – App Runner service running

## Code Highlights
- Simple Node.js/Express API with `/` and `/health` endpoints
- Dockerfile using lightweight `node:20-slim` base image
- Local testing before AWS deployment

## Improvements & Notes
- App Runner provides built-in HTTPS, scaling, and health checks — no manual ALB or ASG config
- Low-cost for demo (free tier covers 100 hours/month active)
- Natural evolution from EC2/Lightsail to serverless containers

Built December 2025.
