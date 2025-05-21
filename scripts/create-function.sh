#!/bin/bash
# Script to create a new Lambda function

# Check if function name is provided
if [ -z "$1" ]; then
    echo "Error: Function name is required"
    echo "Usage: ./create-function.sh <function-name>"
    exit 1
fi

FUNCTION_NAME=$1
FUNCTION_DIR="functions/$FUNCTION_NAME"

# Check if function already exists
if [ -d "$FUNCTION_DIR" ]; then
    echo "Error: Function '$FUNCTION_NAME' already exists"
    exit 1
fi

# Create function directory structure
echo "Creating function: $FUNCTION_NAME"
mkdir -p "$FUNCTION_DIR/src"
mkdir -p "$FUNCTION_DIR/tests"

# Create app.py with Lambda handler
cat > "$FUNCTION_DIR/src/app.py" << 'EOF'
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
            'body': {
                'message': message,
                'input': event
            }
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
            'body': {
                'message': f"Error: {str(e)}"
            }
        }
EOF

# Create test_app.py
cat > "$FUNCTION_DIR/tests/test_app.py" << 'EOF'
import json
import unittest
from unittest.mock import patch, MagicMock

# Import the Lambda handler
from src.app import lambda_handler

class TestLambdaHandler(unittest.TestCase):
    """
    Test cases for the Lambda function
    """
    
    def test_lambda_handler_basic(self):
        """Test the Lambda handler with basic input"""
        # Create a mock event
        event = {
            'queryStringParameters': None,
            'pathParameters': None
        }
        
        # Create a mock context
        context = MagicMock()
        
        # Call the Lambda handler
        response = lambda_handler(event, context)
        
        # Assert the response
        self.assertEqual(response['statusCode'], 200)
        self.assertEqual(response['headers']['Content-Type'], 'application/json')
        self.assertEqual(response['body']['message'], 'Hello from Lambda!')

if __name__ == '__main__':
    unittest.main()
EOF

# Create requirements.txt
cat > "$FUNCTION_DIR/requirements.txt" << 'EOF'
# Required packages for the Lambda function
# Add or remove packages as needed for your specific Lambda function

# AWS SDK for Python
boto3==1.26.135
botocore==1.29.135

# For testing
pytest==7.3.1
pytest-mock==3.10.0
EOF

# Update template.yaml to include the new function
# This is a simplified approach - for production, consider using yq or similar tools
FUNCTION_RESOURCE=$(cat << EOF

  ${FUNCTION_NAME//-/}Function:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: functions/${FUNCTION_NAME}/
      Handler: src/app.lambda_handler
      Description: ${FUNCTION_NAME} Lambda function
      Events:
        ApiEvent:
          Type: Api
          Properties:
            Path: /${FUNCTION_NAME}
            Method: get
      Tags:
        Project: LambdaManagement
        Environment: dev
EOF
)

FUNCTION_OUTPUT=$(cat << EOF

  ${FUNCTION_NAME//-/}Function:
    Description: "${FUNCTION_NAME} Lambda Function ARN"
    Value: !GetAtt ${FUNCTION_NAME//-/}Function.Arn
  ${FUNCTION_NAME//-/}FunctionApi:
    Description: "API Gateway endpoint URL for ${FUNCTION_NAME} function"
    Value: !Sub "https://\${ServerlessRestApi}.execute-api.\${AWS::Region}.amazonaws.com/Prod/${FUNCTION_NAME}"
EOF
)

# Add the new function to template.yaml
sed -i "/Resources:/a\\$FUNCTION_RESOURCE" template.yaml
sed -i "/Outputs:/a\\$FUNCTION_OUTPUT" template.yaml

echo "Function '$FUNCTION_NAME' created successfully!"
echo "Added to template.yaml"
echo ""
echo "Next steps:"
echo "1. Customize the function logic in $FUNCTION_DIR/src/app.py"
echo "2. Update tests in $FUNCTION_DIR/tests/test_app.py"
echo "3. Add any required dependencies to $FUNCTION_DIR/requirements.txt"
echo ""
echo "To test locally:"
echo "cd $FUNCTION_DIR"
echo "python -m venv .venv"
echo "source .venv/bin/activate  # On Windows: .venv\\Scripts\\activate"
echo "pip install -r requirements.txt"
echo "cd ../.."
echo "sam local invoke ${FUNCTION_NAME//-/}Function"
