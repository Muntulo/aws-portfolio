# aws-portfolio
Hands-on AWS projects demonstrating skills in hosting, scaling, security, and more.

## [Project 1 – Final Secure Static Site](projects/project1-static-site/)
- Private S3 bucket + OAC (no public access)
- Correct bucket policy with ListBucket + GetObject
- CloudFront Default Root Object = index.html (fixed XML directory listing bug)
- Custom 404 page via CloudFront error response
- Live at https://gmmguerra.com

## [Project 2 – WordPress Blog on AWS Lightsail](projects/project2-wordpress-lightsail/)
- Fully managed WordPress instance using the official Bitnami blueprint
- Static public IP attached + Route 53 A-record for blog.gmmguerra.com
- Let’s Encrypt SSL enabled with automatic renewal (one-click bncert-tool)
- Daily automated snapshots + manual backup strategy via UpdraftPlus
- Firewall restricted to HTTP/HTTPS + SSH (only from my IP)
- Immediate post-launch hardening: strong admin password, core/plugin updates, Wordfence security plugin
- Live at https://blog.gmmguerra.com (this very blog documenting my AWS journey!)

## [Project 3 – EC2-based Web Server](projects/project3-ec2-web-server/)
- Amazon Linux 2023 t3.micro with custom Apache/httpd installation
- Security Group firewall + IMDSv2-only + IAM instance profile
- Let’s Encrypt SSL via certbot (or ACM certificate if behind ALB later)
- CloudWatch Agent for logs and metrics
- Elastic IP attached for permanent address
- Live at 52.201.28.243

## [Project 4 – Scalable Web App with ALB & Auto Scaling](projects/project4-scalable-alb/)
- EC2 ASG (2-4 t3.micro instances) behind internet-facing ALB with health checks
- Launch template with user data for Apache + unique instance greeting
- CPU target tracking scaling (50% threshold) + CloudWatch alarms
- Route 53 alias to ALB DNS for seamless access
- Load tested with Apache Bench to verify auto-scale-out
- Automated with AWS CDK (Python) for code-based IaC

## [Project 5 – Multi-Tier Web Application with IaC](projects/project5-multi-tier/)
- Fully automated deployment of multi-tier application using Terraform
- VPC with public/private subnets, Regional NAT Gateway, and route tables
- Internet-facing ALB with HTTPS (ACM wildcard cert) and HTTP → HTTPS redirect
- Private EC2 Auto Scaling Group (Graviton instances) with launch template
- Private RDS MySQL database
- Security Groups with least-privilege rules
- Live at https://app.gmmguerra.com (when deployed)
- Code: [projects/project5-multi-tier/iac-terraform/](projects/project5-multi-tier/iac-terraform/)

## [Project 6 – Serverless Static Website](projects/project6-serverless-static-website/)
- Private S3 bucket with OAC for secure origin
- CloudFront CDN on Free plan with CloudFront Functions for edge logic (geo headers)
- ACM wildcard HTTPS + HTTP → HTTPS redirect
- Route 53 alias for custom domain
- Live at https://serverless.gmmguerra.com (responsive portfolio page with client-side features)

## [Project 7 – Progressive Web App Hosting](projects/project7-pwa-hosting/)
- Modern React + Vite PWA deployed with AWS Amplify CI/CD
- Automatic builds on GitHub push, global CDN hosting
- Offline support, installable on mobile/desktop
- ACM HTTPS + Route 53 custom domain
- Live at https://pwa.gmmguerra.com

## [Project 8 – Containerized Serverless API with App Runner](projects/project8-app-runner-demo/)
- Dockerized Node.js/Express API pushed to Amazon ECR
- Deployed with AWS App Runner — fully managed containers (no EC2, ALB, or VPC)
- Automatic HTTPS, health checks, and auto-scaling
- First hands-on Docker experience
- Live at https://exx24tmpap.us-east-1.awsapprunner.com

## [Project 9 – Serverless Image Analyzer](projects/project9-serverless-image-analyzer/)
- Secure image uploads to private S3 with presigned POST URLs
- Event-triggered Lambda + Rekognition for label/text detection
- API Gateway for results retrieval
- Frontend display of analysis
- Live demo at https://serverless.gmmguerra.com/image-analyzer.html

## [Project 10 – AI-Powered Chat Bot with RAG](projects/project10-ai-powered-chat-bot/)
- Serverless RAG chatbot using Amazon Bedrock Knowledge Bases for retrieval-augmented generation
- PDFs of AWS certification exam guides ingested for accurate, grounded responses
- Event-driven backend with API Gateway + Lambda + Bedrock
- Simple chat frontend hosted on existing serverless static site
- Live demo at https://serverless.gmmguerra.com/chat-bot.html

## [Project 11 – AI Text Summarizer](projects/project11-ai-text-summarizer/)
- Serverless text summarizer using Amazon Bedrock Claude
- Paste text → Get concise bullet-point summary in real-time
- API Gateway + Lambda backend
- Hosted on existing serverless static site
- Live at https://serverless.gmmguerra.com/summarizer.html