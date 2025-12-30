# Project 9 – Serverless Image Analyzer

## Overview
Built a serverless application that analyzes uploaded images using AWS Rekognition for labels, objects, and text detection. Demonstrates event-driven architecture, secure uploads, and AI/ML integration.

**Key AWS Services**
- S3 (private bucket for image storage)
- Lambda (event-triggered analysis)
- Rekognition (image AI)
- API Gateway (presigned URLs + results API)
- CloudFront (frontend hosting)

**Live Demo**
https://serverless.gmmguerra.com/image-analyzer.html – Upload an image to see results

## Architecture Highlights
- Frontend uploads to S3 via presigned POST URLs (secure, no public bucket)
- S3 event triggers Lambda on upload
- Lambda calls Rekognition for analysis
- Frontend polls API for results display

## Screenshots
- `image-analyzer-frontend-live.png` – Frontend with upload and results
- `rekognition-success-logs.png` – CloudWatch logs with results
- `image-analyzer-frontend-results.png` – Frontend showing analisis results
- And more...

## Code Highlights
- Python Lambda for Rekognition integration
- JS frontend for presigned uploads and results display
- Bucket policy for Rekognition access

## Improvements & Notes
- Used presigned POST for secure browser uploads (better than PUT for headers)
- Event-driven (S3 trigger) for real-time analysis
- Free tier covers demo traffic
- Future: Add DynamoDB for result storage

This project shows AI/ML in serverless workflows.
