# Project 4 – Scalable Web App with ALB & Auto Scaling (IaC with AWS CDK)

## Overview
Automated the scalable web app from Project 4 using AWS CDK (Python) — code-based Infrastructure as Code.

**Key Features**
- VPC with public subnets
- Internet-facing ALB with HTTP listener
- Auto Scaling Group with launch template (Apache web server)
- Security Groups with least-privilege rules

**Live Demo** (when deployed)
http://appsca-albae-irpxwoz9kgnl-1221160774.us-east-1.elb.amazonaws.com/ – "Hello from Scalable App (CDK)"

## Why CDK?
- Code-first IaC (Python) — modern 2025 preference over YAML.
- Builds on manual Project 4 — shows progression to automation.

## Code Highlights
- `app_scalable_alb_stack.py` – Full stack definition
- `app.py` – Entry point

## Deployment
```bash
cdk deploy  # Creates stack
cdk destroy # Cleans up to $0