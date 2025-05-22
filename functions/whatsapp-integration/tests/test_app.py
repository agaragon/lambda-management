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
        body = json.loads(response['body'])
        # Assert the response
        self.assertEqual(response['statusCode'], 200)
        self.assertEqual(response['headers']['Content-Type'], 'application/json')
        self.assertEqual(body['message'], 'Hello from Lambda!')

if __name__ == '__main__':
    unittest.main()
