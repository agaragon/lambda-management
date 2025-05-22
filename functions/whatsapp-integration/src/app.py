import json

def lambda_handler(event, context):
    """
    Lambda function handler
    
    Parameters:
    -----------
    event : dict
        The event data passed to the Lambda function
    context : LambdaContext
        The runtime information provided by AWS Lambda
        
    Returns:
    --------
    dict
        Response object with statusCode and body
    """
    try:
        # Extract parameters from the event
        query_parameters = event.get('queryStringParameters', {}) or {}
        path_parameters = event.get('pathParameters', {}) or {}
        
        # Process the request (implement your logic here)
        message = "Hello from Lambda!"
        
        # Return a successful response
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'message': message,
                'input': event
            })
        }
    except Exception as e:
        # Log the error
        print(f"Error: {str(e)}")
        
        # Return an error response
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'message': f"Error: {str(e)}"
            })
        }
