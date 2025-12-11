# Project 2: WordPress on AWS Lightsail – Deploy a Managed WordPress Blog

## Overview
Based on Build_now.pdf Project 2 (Traditional & Scalable Hosting section), this project deploys a production-ready WordPress blog using AWS Lightsail—a simplified VM service for beginners. Lightsail handles OS patching, networking, and scaling basics, making it ideal for quick CMS setups vs. manual EC2 configs (Project 3).

**Key AWS Services**:
- **Lightsail**: Managed instances with pre-baked WordPress blueprints (includes Apache, PHP, MySQL).
- **Route 53**: DNS for domain routing.
- **Snapshots**: Built-in backups for disaster recovery.

**Live Demo**: [blog.gmmguerra.com](https://blog.gmmguerra.com) – My personal AWS journey blog, hosted here since Dec 2025.

**Time to Complete**: 10-15 minutes (as experienced; PDF estimates similar).
**Cost**: ~$3.50/month (nano instance) + domain fees; free tier covers initial testing.

## What I Did (Extracted from My Deployment Blog)
From my hands-on setup documented at [AWS Hands-On Projects #2 Blog Post](https://blog.gmmguerra.com/2025/12/02/aws-hands-on-projects-2-how-i-set-up-this-wordpress-blog-on-aws-lightsail/):

1. **Prerequisites**:
   - AWS account with Lightsail access (free tier eligible).
   - Registered domain (e.g., gmmguerra.com via Route 53).
   - Basic WP knowledge (themes/plugins).

2. **Create Lightsail Instance**:
   - Lightsail Console > Create instance.
   - Region: us-east-1 (low latency for global users).
   - Platform: Linux/Unix > Blueprint: WordPress (pre-configured LAMP stack).
   - Instance plan: Nano (512 MB RAM, 1 vCPU, 20 GB SSD – sufficient for low-traffic blog).
   - Instance name: `wordpress-blog-prod`.
   - Launch > Wait 2-3 min for SSH access (auto-generated key pair).

3. **Assign Static IP and Domain Setup**:
   - Networking tab > Create static IP > Attach to instance (prevents IP changes on stop/start).
   - Route 53 > Hosted zone > Create A record: `blog` → Static IP (e.g., 3.123.45.67).
   - Wait for DNS propagation (5-60 min; tested with `dig blog.gmmguerra.com`).

4. **Initial Configuration and Security**:
   - SSH into instance (Lightsail browser-based console or CLI: `ssh -i key.pem bitnami@static-ip`).
   - Access WP admin: https://blog.gmmguerra.com/wp-admin (default creds: user `user`, pass from Lightsail snapshot).
   - Update WP core/plugins/themes via dashboard.
   - Enable HTTPS: Install free Let's Encrypt cert via Lightsail's one-click (or SSH: `sudo /opt/bitnami/bncert-tool`).

5. **Post-Deployment Steps**:
   - Install plugins: Yoast SEO, UpdraftPlus (backups), Wordfence (security).
   - Customize: Set permalink structure, add AWS-themed content.
   - Enable automatic snapshots: Lightsail > Snapshots > Create recurring (daily at 2 AM UTC).

**Challenges Faced** (From Blog):
- DNS propagation delays caused initial 404s—resolved by flushing local DNS cache.
- Default Bitnami WP image needed immediate password change for security.

## PDF Suggestions vs. What I Implemented
The PDF outlines a basic flow (create instance > access WP > customize), but lacks 2025 updates like auto-HTTPS and monitoring. Here's a comparison:

## Code/Config Snippets
- **Static IP Attachment Script** (Optional CLI for repeatability):
  ```bash
  aws lightsail attach-static-ip --static-ip-name wordpress-ip --instance-name wordpress-blog-prod --region us-east-1
