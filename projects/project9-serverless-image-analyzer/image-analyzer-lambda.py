import json
import boto3
import urllib.parse

s3 = boto3.client('s3')
rekognition = boto3.client('rekognition')

def lambda_handler(event, context):
    # Get bucket and key from S3 event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'])
    
    print(f"New image uploaded: {bucket}/{key}")
    
    # Call Rekognition to detect labels
    response = rekognition.detect_labels(
        Image={'S3Object': {'Bucket': bucket, 'Name': key}},
        MaxLabels=10,
        MinConfidence=80
    )
    
    labels = [label['Name'] for label in response['Labels']]
    
    # Optional: Detect text
    text_response = rekognition.detect_text(
        Image={'S3Object': {'Bucket': bucket, 'Name': key}}
    )
    
    text = [detection['DetectedText'] for detection in text_response['TextDetections']]
    
    result = {
        'image': key,
        'labels': labels,
        'text': text
    }
    
    print("Analysis result:", result)
    
    # For now, just log — later we'll store in DynamoDB or return via API
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }