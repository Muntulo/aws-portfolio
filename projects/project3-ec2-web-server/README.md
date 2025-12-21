# Project 3 – EC2-based Web Server (Apache/Nginx)

## Overview
Manually configured a custom web server on Amazon EC2 (Amazon Linux 2023) instead of using a managed service like Lightsail. This project shows full control over the OS, web server, and security settings — the classic “pets vs cattle” building block before we move to auto-scaling in Project 4.

**Key AWS Services Used**
- EC2 t3.micro (or t4g.micro Graviton for extra credit)
- Security Group acting as firewall
- EBS gp3 volume
- Elastic IP (optional)
- IAM instance profile with minimal permissions

## What I Did
1. Launched EC2 instance (Amazon Linux 2023) in a public subnet  
2. Connected via Session Manager (no SSH keys needed)  
3. Installed and hardened Apache/httpd (`sudo dnf install httpd -y`)  
4. Configured firewall: only 80, 443, and ICMP open  
5. Created a simple custom homepage + server-info page  
6. Enabled and started httpd + set to survive reboot  
7. (Optional) Added Let’s Encrypt SSL with certbot  
8. Attached Elastic IP so the address never changes

## 2025 Best-Practice Touches I Added
- Used IMDSv2 only (blocked IMDSv1)  
- Instance profile instead of storing keys on the box  
- Custom Security Group with least-privilege rules  
- CloudWatch Agent collecting system logs metrics  
- Tagged everything (`Project=EC2WebServer`, `Environment=Prod`)

## Screenshots to upload

1. EC2 console → instance list (show Running state + public IPv4)  
2. Security Group inbound rules (22 or SSM, 80, 443 only)  
3. Session Manager connection screenshot (or `ssh ec2-user@…` if you used keys)  
4. Terminal: `sudo systemctl status httpd` (active running)  
5. Browser: your custom page loading at the public IP or subdomain  
