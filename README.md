# aws-portfolio
Hands-on AWS projects demonstrating skills in hosting, scaling, security, and more.

## Project 1 – Final Secure Static Site (Dec 2025 best practices)
- Private S3 bucket + OAC (no public access)
- Correct bucket policy with ListBucket + GetObject
- CloudFront Default Root Object = index.html (fixed XML directory listing bug)
- Custom 404 page via CloudFront error response
- Live at https://gmmguerra.com

## Project 2 – WordPress Blog on AWS Lightsail (Dec 2025 best practices)
- Fully managed WordPress instance using the official Bitnami blueprint
- Static public IP attached + Route 53 A-record for blog.gmmguerra.com
- Let’s Encrypt SSL enabled with automatic renewal (one-click bncert-tool)
- Daily automated snapshots + manual backup strategy via UpdraftPlus
- Firewall restricted to HTTP/HTTPS + SSH (only from my IP)
- Immediate post-launch hardening: strong admin password, core/plugin updates, Wordfence security plugin
- Live at https://blog.gmmguerra.com (this very blog documenting my AWS journey!)

## Project 3 – EC2-based Web Server (Dec 2025 best practices)
- Amazon Linux 2023 t3.micro with custom Apache/httpd installation
- Security Group firewall + IMDSv2-only + IAM instance profile
- Let’s Encrypt SSL via certbot (or ACM certificate if behind ALB later)
- CloudWatch Agent for logs and metrics
- Elastic IP attached for permanent address
- Live at 52.201.28.243

## Project 4 – Scalable Web App with ALB & Auto Scaling (Dec 2025 best practices)
- EC2 ASG (2-4 t3.micro instances) behind internet-facing ALB with health checks
- Launch template with user data for Apache + unique instance greeting
- CPU target tracking scaling (50% threshold) + CloudWatch alarms
- Route 53 alias to ALB DNS for seamless access
- Load tested with Apache Bench to verify auto-scale-out
