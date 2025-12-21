# aws-portfolio
Hands-on AWS projects demonstrating skills in hosting, scaling, security, and more.

## Project 1 – Final Secure Static Site (projects/project1-static-site/)
- Private S3 bucket + OAC (no public access)
- Correct bucket policy with ListBucket + GetObject
- CloudFront Default Root Object = index.html (fixed XML directory listing bug)
- Custom 404 page via CloudFront error response
- Live at https://gmmguerra.com

## Project 2 – WordPress Blog on AWS Lightsail (projects/project2-wordpress-lightsail/)
- Fully managed WordPress instance using the official Bitnami blueprint
- Static public IP attached + Route 53 A-record for blog.gmmguerra.com
- Let’s Encrypt SSL enabled with automatic renewal (one-click bncert-tool)
- Daily automated snapshots + manual backup strategy via UpdraftPlus
- Firewall restricted to HTTP/HTTPS + SSH (only from my IP)
- Immediate post-launch hardening: strong admin password, core/plugin updates, Wordfence security plugin
- Live at https://blog.gmmguerra.com (this very blog documenting my AWS journey!)

## Project 3 – EC2-based Web Server (projects/project3-ec2-web-server/)
- Amazon Linux 2023 t3.micro with custom Apache/httpd installation
- Security Group firewall + IMDSv2-only + IAM instance profile
- Let’s Encrypt SSL via certbot (or ACM certificate if behind ALB later)
- CloudWatch Agent for logs and metrics
- Elastic IP attached for permanent address
- Live at 52.201.28.243

## Project 4 – Scalable Web App with ALB & Auto Scaling (projects/project4-scalable-alb/)
- EC2 ASG (2-4 t3.micro instances) behind internet-facing ALB with health checks
- Launch template with user data for Apache + unique instance greeting
- CPU target tracking scaling (50% threshold) + CloudWatch alarms
- Route 53 alias to ALB DNS for seamless access
- Load tested with Apache Bench to verify auto-scale-out

## Project 5 – Multi-Tier Web Application (projects/project5-multi-tier/)
- Custom VPC with public/private subnets across 2 AZs and Regional NAT Gateway
- Internet-facing ALB with HTTPS termination (ACM wildcard cert) and HTTP → HTTPS redirect
- Auto Scaling Group of Graviton t2.micro (free tier) instances in private subnets
- Private RDS MySQL database with secure connection from web tier
- Least-privilege Security Groups
- CloudWatch alarms for CPU utilization
- Live at https://app.gmmguerra.com (PHP app with database-backed visit counter)

## Project 6 – Serverless Static Website (projects/project6-serverless-static-website/)
- Private S3 bucket with OAC for secure origin
- CloudFront CDN on Free plan with CloudFront Functions for edge logic (geo headers)
- ACM wildcard HTTPS + HTTP → HTTPS redirect
- Route 53 alias for custom domain
- Live at https://serverless.gmmguerra.com (responsive portfolio page with client-side features)

## Project 7 – Progressive Web App Hosting (projects/project7-pwa-hosting/)
- Modern React + Vite PWA deployed with AWS Amplify CI/CD
- Automatic builds on GitHub push, global CDN hosting
- Offline support, installable on mobile/desktop
- ACM HTTPS + Route 53 custom domain
- Live at https://pwa.gmmguerra.com
