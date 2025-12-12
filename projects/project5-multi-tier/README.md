# Project 5 – Multi-Tier Web Application with VPC, ALB, EC2 Auto Scaling, and RDS

## Overview
Deployed a secure, highly available, multi-tier web application with separate public and private subnets. The architecture follows modern best practices: internet traffic hits an Application Load Balancer in public subnets, which forwards to auto-scaling EC2 instances in private subnets, which connect to a private MySQL RDS database.

**Key AWS Services**
- VPC with public/private subnets across 2 AZs and Regional NAT Gateway
- Application Load Balancer (internet-facing) with HTTPS termination and HTTP → HTTPS redirect
- Auto Scaling Group using t2.micro (free tier) instances and launch template with user data
- RDS MySQL (single-AZ free tier) in private subnets
- Security Groups with least-privilege rules
- Route 53 alias for custom domain
- CloudWatch alarms for CPU

**Live Demo**  
https://app.gmmguerra.com – Simple PHP app demonstrating database connectivity and visit counter.

## Architecture Highlights
- Public subnets: ALB only
- Private subnets: EC2 ASG and RDS (no public access)
- VPC endpoints for S3 and DynamoDB (cost optimization)
- Secrets Manager explored for credential management (direct connection used for demo simplicity)
- HTTPS enforced via ACM wildcard certificate

## Screenshots

- `vpc overview.png` – VPC with public/private subnets and Regional NAT
- `security-groups-list.png` – Least-privilege SG rules (ALB → EC2 → RDS)
- `alb-https-listener.png` – HTTPS listener with ACM cert + HTTP redirect
- `asg-private-subnets.png` – ASG in private subnets with healthy targets
- `rds-private.png` – RDS in private subnets with endpoint
- `app-https-live.png` – Final app running at https://app.gmmguerra.com with visit counter
- `cloudwatch-alarm.png` – CPU

## Improvements Beyond Basic Design
- Used Graviton instances for better price/performance
- Regional NAT Gateway for resilient outbound access
- VPC endpoints to reduce NAT data charges
- CloudWatch alarms for proactive monitoring
- Full HTTPS enforcement with automatic redirect

This project demonstrates a production-ready architecture suitable for real-world applications requiring security, scalability, and high availability.
