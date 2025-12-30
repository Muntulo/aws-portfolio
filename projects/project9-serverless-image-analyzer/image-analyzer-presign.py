import json
import boto3
import urllib.parse

s3 = boto3.client('s3')
BUCKET = 'image-analyzer-uploads-2025-gmmguerra'

def lambda_handler(event, context):
    try:
        # Get filename from query string
        filename = event['queryStringParameters']['filename']
        if not filename:
            raise ValueError("Filename is required")
    except (KeyError, ValueError) as e:
        return {
            'statusCode': 400,
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
            'body': json.dumps({'error': str(e)})
        }

    key = f'uploads/{urllib.parse.quote(filename)}'

    try:
        url = s3.generate_presigned_post(
            Bucket=BUCKET,
            Key=key,
            Fields={"Content-Type": "image/*"},
            Conditions=[
                {"Content-Type": "image/*"},
                ["content-length-range", 1, 10485760]  # 1 byte to 10MB
            ],
            ExpiresIn=300
        )
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
            'body': json.dumps({'error': 'Failed to generate presigned URL', 'details': str(e)})
        }

    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
        'body': json.dumps(url)
    }