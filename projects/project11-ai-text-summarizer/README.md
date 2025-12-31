# Project 11 – AI Text Summarizer

## Overview
Built a serverless text summarizer using Amazon Bedrock Claude for generative AI. Users paste text — the app returns a concise summary in real-time.

Demonstrates LLM API integration, prompt engineering, and serverless backend.

**Key AWS Services**
- **Amazon Bedrock** – Claude 3 Haiku for summarization
- **AWS Lambda** – Serverless function to call Bedrock
- **Amazon API Gateway** – REST endpoint for frontend
- **S3 + CloudFront** – Frontend hosting (on existing serverless site)

**Live Demo**
https://serverless.gmmguerra.com/summarizer.html – Paste text to see summary

## Architecture Highlights
- Frontend calls API Gateway → Lambda → Bedrock Claude
- Prompt tuned for 3-5 bullet point summaries
- Serverless end-to-end — no infrastructure management
- Low-cost (Bedrock free tier + Lambda/API free tier)

## Screenshots
- `summarizer-frontend.png` – Upload page with results
- `summarizer-lambda-code.png` – Lambda with Bedrock call
- `summarizer-api-setup.png` – API Gateway endpoint

## Code Highlights
- Simple HTML/JS frontend with async fetch
- Python Lambda using Bedrock runtime client
- Secure, serverless AI workflow

## Improvements & Notes
- Used Claude 3 Haiku for fast, low-cost summarization
- Easy to extend (different models, prompt tuning)
- Free tier covers demo usage
- Future: Add length selector, multi-language support

This project shows practical generative AI integration
