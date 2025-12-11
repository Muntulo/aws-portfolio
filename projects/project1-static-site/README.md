# Project 1: Static Website Hosting on S3 with Route 53 & CloudFront

## Overview
Hosted my AWS journey site at [gmmguerra.com](https://gmmguerra.com). Used S3 for storage, CloudFront for CDN, and Route 53 for DNS.

## Key AWS Services
- S3: Static hosting with private bucket and OAC.
- CloudFront: Global caching and HTTPS.
- Route 53: Domain routing.

## Improvements
- Updated to private S3 with restricted policy for security.
- Added error handling.

## Screenshots
(We'll add these next.)

## Code/Config
- Bucket Policy: [bucket-policy.json](bucket-policy.json)

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
