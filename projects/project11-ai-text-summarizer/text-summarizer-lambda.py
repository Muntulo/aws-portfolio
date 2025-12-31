import json
import boto3

bedrock = boto3.client('bedrock-runtime')

def lambda_handler(event, context):
    try:
        text = event['queryStringParameters']['text']
    except KeyError:
        return {'statusCode': 400, 'body': json.dumps({'error': 'Missing text parameter'})}

    try:
        response = bedrock.invoke_model(
            modelId='anthropic.claude-3-haiku-20240307-v1:0',
            body=json.dumps({
                "anthropic_version": "bedrock-2023-05-31",
                "max_tokens": 1000,
                "messages": [{"role": "user", "content": f"Summarize this text in 3-5 bullet points:\n\n{text}"}]
            })
        )

        result = json.loads(response['body'].read())
        summary = result['content'][0]['text']

        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
            'body': json.dumps({'summary': summary})
        }
    except Exception as e:
        return {'statusCode': 500, 'body': json.dumps({'error': str(e)})}