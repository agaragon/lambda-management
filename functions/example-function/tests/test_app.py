import json
import unittest
from unittest.mock import patch, MagicMock

# Import the Lambda handler
from src.app import lambda_handler

class TestLambdaHandler(unittest.TestCase):
    """
    Test cases for the example Lambda function
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
    
    def test_lambda_handler_with_name(self):
        """Test the Lambda handler with a name parameter"""
        # Create a mock event with a name parameter
        event = {
            'queryStringParameters': {'name': 'Test User'},
            'pathParameters': None
        }
        
        # Create a mock context
        context = MagicMock()
        
        # Call the Lambda handler
        response = lambda_handler(event, context)
        
        # Assert the response
        self.assertEqual(response['statusCode'], 200)
        self.assertEqual(response['headers']['Content-Type'], 'application/json')
        self.assertEqual(response['body']['message'], 'Hello, Test User!')
    
    @patch('src.app.print')
    def test_lambda_handler_exception(self, mock_print):
        """Test the Lambda handler with an exception"""
        # Create a mock event that will cause an exception
        event = None  # This will cause an exception when accessing .get()
        
        # Create a mock context
        context = MagicMock()
        
        # Call the Lambda handler
        response = lambda_handler(event, context)
        
        # Assert the response
        self.assertEqual(response['statusCode'], 500)
        self.assertEqual(response['headers']['Content-Type'], 'application/json')
        self.assertTrue('Error:' in response['body']['message'])
        
        # Assert that the error was logged
        mock_print.assert_called()

if __name__ == '__main__':
    unittest.main()
