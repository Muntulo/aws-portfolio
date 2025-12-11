# Project 4 – Scalable Web App with ALB & Auto Scaling

## Overview
Building on Project 3's single EC2 web server, this deploys a highly available, auto-scaling web application using an Application Load Balancer (ALB) to distribute traffic across multiple EC2 instances in an Auto Scaling Group (ASG). It demonstrates fault tolerance, load distribution, and dynamic scaling—essential for production workloads.

**Key AWS Services**:
- **EC2 Auto Scaling Group (ASG)**: Maintains 2-4 instances based on CPU load.
- **Application Load Balancer (ALB)**: Layer 7 routing with health checks and target groups.
- **Launch Template**: Defines AMI, instance type, user data for Apache setup.
- **CloudWatch**: Alarms trigger scaling policies.
- **VPC/Security Groups**: Basic networking (public subnet for ALB, private for EC2—prep for Project 6).


## What I Did (Based on Blog & PDF Steps)

1. **Launch Template Creation**:
   - EC2 Console > Launch Templates > Create.
   - AMI: Amazon Linux 2023; Instance type: t3.micro
   - User data script: Install Apache (`#!/bin/bash yum install httpd -y; systemctl start httpd; echo "<h1>Hello from $(hostname)!</h1>" > /var/www/html/index.html`).
   - Security: IAM role for CloudWatch logs (no stored keys).

2. **Auto Scaling Group Setup**:
   - EC2 > Auto Scaling Groups > Create.
   - Launch template: Select above; Min: 2, Max: 4, Desired: 2.
   - VPC: Default
   - Scaling policies: Target tracking (CPU 50% avg); Add capacity on alarm.

3. **ALB Configuration**:
   - EC2 > Load Balancers > Create ALB (internet-facing).
   - Listeners: HTTP:80 → HTTPS:443 (or redirect); Target group: HTTP:80 with health check `/` (200 OK).
   - Attach ASG to target group.

4. **DNS & Testing**:
   - Route 53 > Create A record (alias to ALB DNS).
   - Test scaling: Use `ab -n 1000 -c 100 http://app.gmmguerra.com/` (Apache Bench) to simulate load → Watch ASG scale out.
   - Blog challenge: Initial health check failures due to instance boot time—fixed with 300s warmup.

5. **Post-Deployment**:
   - Enable CloudWatch alarms (CPU >70% scale up, <30% scale in).
   - Tag resources (`Project:ScalableApp`, `AutoScale:Yes`).


## Code/Config Snippets
- **User Data Script** (Launch Template):
  ```bash
  #!/bin/bash
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "<h1>Welcome to Scalable Web App</h1>" | sudo tee /var/www/html/index.html


