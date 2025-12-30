import json
import boto3
import urllib.parse

rekognition = boto3.client('rekognition')
BUCKET = 'image-analyzer-uploads-2025-gmmguerra'

def lambda_handler(event, context):
    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
    }
    
    # Safe parameter extraction
    query_params = event.get('queryStringParameters') or {}
    key = query_params.get('key')
    
    if not key:
        return {
            'statusCode': 400, 
            'headers': headers,
            'body': json.dumps({'error': 'Missing key parameter'})
        }
    
    # Don't decode - use the key as-is since S3 stores it URL encoded
    print(f"Lambda received key: '{key}'")
    
    # Debug: List what's actually in the uploads folder
    s3 = boto3.client('s3')
    try:
        response = s3.list_objects_v2(Bucket=BUCKET, Prefix='uploads/')
        if 'Contents' in response:
            print("Files in uploads/:")
            for obj in response['Contents']:
                print(f"  '{obj['Key']}'")
                if obj['Key'] == key:
                    print(f"  ✓ MATCH FOUND: {key}")
    except Exception as list_error:
        print(f"Error listing S3 objects: {list_error}")
    
    # Try both encoded and decoded versions
    possible_keys = [
        key,
        urllib.parse.quote_plus(key),  # Encode spaces as %20
        urllib.parse.quote(key),       # Alternative encoding
        urllib.parse.unquote_plus(key),
        urllib.parse.unquote(key)
    ]
    
    working_key = None
    for test_key in possible_keys:
        try:
            s3.head_object(Bucket=BUCKET, Key=test_key)
            working_key = test_key
            print(f"✓ Found working key: '{working_key}'")
            break
        except:
            print(f"✗ Key not found: '{test_key}'")
    
    if not working_key:
        return {
            'statusCode': 404,
            'headers': headers,
            'body': json.dumps({'error': f'Object not found. Tried: {possible_keys}'})
        }

    try:
        # Detect labels
        labels_response = rekognition.detect_labels(
            Image={'S3Object': {'Bucket': BUCKET, 'Name': working_key}},
            MaxLabels=10,
            MinConfidence=70
        )
        labels = [label['Name'] for label in labels_response['Labels']]

        # Detect text
        text_response = rekognition.detect_text(
            Image={'S3Object': {'Bucket': BUCKET, 'Name': working_key}}
        )
        text = [detection['DetectedText'] for detection in text_response['TextDetections'] if detection['Type'] == 'LINE']

        return {
            'statusCode': 200, 
            'headers': headers,
            'body': json.dumps({'labels': labels, 'text': text})
        }
    except Exception as e:
        print(f"Error processing key '{key}': {str(e)}")  # Debug log
        return {
            'statusCode': 500, 
            'headers': headers,
            'body': json.dumps({'error': str(e)})
        }