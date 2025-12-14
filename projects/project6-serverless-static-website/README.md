# Project 6 – Serverless Static Website

## Overview
Built a fully serverless static website using modern AWS services. The site is hosted on a private S3 bucket, globally distributed via CloudFront, protected with HTTPS, and enhanced with lightweight edge logic using CloudFront Functions.

**Key AWS Services**
- S3 (private bucket with static website hosting)
- CloudFront (CDN on Free plan with automatic OAC)
- CloudFront Functions (edge compute for custom headers)
- ACM (wildcard certificate for HTTPS)
- Route 53 (custom domain alias)

**Live Demo**  
https://serverless.gmmguerra.com – Responsive portfolio page with client-side visit counter and location detection.

## Architecture Highlights
- Private S3 bucket with Origin Access Control (OAC) — no public access
- CloudFront automatically configured OAC and bucket policy during creation
- CloudFront Functions for viewer-request edge logic (adds visitor country header)
- ACM wildcard certificate for HTTPS enforcement
- Route 53 A-record alias to CloudFront distribution
- All on CloudFront Free plan — zero monthly cost for low traffic

## Screenshots
- `s3-private-bucket.png` – S3 bucket with Block Public Access and static hosting enabled
- `cloudfront-permission-oac.png` – CloudFront creation prompt granting bucket access
- `s3-bucket-policy-oac.png` – Auto-generated bucket policy allowing CloudFront
- `cloudfront-function-code.png` – CloudFront Function adding visitor country header
- `cloudfront-function-associated.png` – Function attached to default behavior
- `route53-serverless-alias.png` – Route 53 alias record to CloudFront
- `serverless-final-live.png` – Final site on custom domain with HTTPS padlock

## Code Highlights
- Simple HTML/CSS/JS site with responsive design and client-side features
- CloudFront Function (JavaScript) for edge personalization
- No backend servers — pure serverless

## Improvements & Notes
- Used CloudFront Free plan (2025 default) with CloudFront Functions instead of paid-tier Lambda@Edge
- Automatic OAC setup during distribution creation (modern console flow)
- Client-side location fallback for visible demo
- Zero ongoing cost for low-traffic usage (free tier covers requests and data transfer)

This project demonstrates fast, secure, globally distributed static hosting with edge customization.
