# Project 10 – AI-Powered Chat Bot with RAG

## Overview
Built a serverless AI-powered FAQ chatbot for AWS certifications using Retrieval-Augmented Generation (RAG) with Amazon Bedrock Knowledge Bases.

The bot answers questions about AWS Certified Cloud Practitioner, AI Practitioner, and Solutions Architect Associate exams by retrieving relevant content from official exam guides and generating accurate responses with Claude 3 Haiku.

**Key AWS Services**
- **Amazon Bedrock** – Knowledge Bases for RAG + Claude 3 Haiku for generation
- **Amazon S3** – Storage for certification PDFs
- **AWS Lambda** – Query handler for the chat API
- **Amazon API Gateway** – REST endpoint for frontend
- **CloudFront** – Frontend hosting (on existing serverless site)

**Live Demo**
https://serverless.gmmguerra.com/chat-bot.html – Ask questions like "What are the 4 domains for SAA-C03?"

## Architecture Highlights
- PDFs uploaded to S3 → ingested into Bedrock Knowledge Base
- Frontend sends query → API Gateway → Lambda → Bedrock KB RAG → response
- Secure, event-driven, fully serverless
- No public bucket — uses private S3 with IAM policies

## Screenshots
- `s3-kb-bucket.png` – S3 bucket with certification PDFs
- `bedrock-kb-ready.png` – Knowledge Base creation
- `lambda-bot-test.png` – Successful test query in console
- `api-bot-created.png` – API Gateway /query endpoint
- `api-bot-deployed.png` – API prod Stage
- `cert-bot-chat-response.png` – Chat UI with question and response

## Code Highlights
- Simple HTML/JS frontend with real-time query/response
- Lambda uses `retrieve_and_generate` for RAG
- Increased retrieval chunks for better accuracy on table content

## Knowledge Base Data
The RAG bot uses these official AWS certification PDFs (uploaded to S3 for Bedrock KB ingestion):
- [Solutions Architect Associate Exam Guide](KB/AWS-Certified-Solutions-Architect-Associate_Exam-Guide.pdf)
- [Cloud Practitioner Exam Guide](KB/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf)
- [AI Practitioner Exam Guide](KB/AWS-Certified-AI-Practitioner_Exam-Guide.pdf)
- [Solutions Architect Associate Exam Sample Questions](KB/AWS_Certified_Solutions_Architect_Associate_Sample_Questions.pdf)
- [Solutions Architect Associate Extra Exam Sample Questions](KB/aws-solutions-architect-associate-exam-questions,pdf)
- [S3 User Guide](KB/s3-userguide.pdf)
- [Well-Architected Framework](KB/wellarchitected-framework)

## Improvements & Notes
- Used Bedrock Knowledge Bases (managed RAG) instead of manual vector store
- Focused on certification PDFs for accurate, grounded answers
- Added retry logic and chunk increase to handle PDF table extraction
- Low-cost (free tier covers demo traffic)
- Future: Add session memory with DynamoDB, voice input with Transcribe

This project demonstrates modern AI integration in serverless workflows
