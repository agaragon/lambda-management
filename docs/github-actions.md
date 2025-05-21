# GitHub Actions Workflow Documentation

This document explains how the GitHub Actions workflow is configured for automatic deployment of Lambda functions.

## Workflow Overview

The GitHub Actions workflow (`deploy.yml`) automates the testing, building, and deployment of Lambda functions to AWS. The workflow is triggered on:

- Pushes to the `main` branch
- Manual workflow dispatch with environment selection

## Workflow Steps

1. **Checkout Code**: Retrieves the repository code
2. **Set up Python**: Configures Python 3.9 environment
3. **Install Dependencies**: Installs AWS SAM CLI and testing tools
4. **Configure AWS Credentials**: Sets up AWS credentials from GitHub Secrets
5. **Install Function Dependencies**: Installs dependencies for each Lambda function
6. **Run Tests**: Executes tests for each Lambda function
7. **Build with SAM**: Builds the Lambda functions using AWS SAM
8. **Deploy with SAM**: Deploys the Lambda functions to AWS
9. **Output Deployed Endpoints**: Displays the API Gateway endpoints for the deployed functions

## GitHub Secrets Setup

To use this workflow, you need to set up the following GitHub Secrets:

1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - `AWS_REGION`: Your preferred AWS region (e.g., us-east-1)
   - `DEPLOYMENT_BUCKET`: (Optional) S3 bucket for deployment artifacts

## Security Considerations

- AWS credentials are securely stored as GitHub Secrets
- The workflow uses the principle of least privilege
- Credentials are never exposed in logs or outputs
- The workflow runs in isolated environments

## Customization

You can customize the workflow by:

- Modifying the `deploy.yml` file
- Adding environment-specific configurations
- Adjusting the deployment parameters in `samconfig.toml`
- Adding pre/post-deployment steps as needed

## Troubleshooting

If deployment fails:

1. Check the GitHub Actions logs for error messages
2. Verify that AWS credentials are correctly set up
3. Ensure the deployment bucket exists in the specified region
4. Validate the SAM template using `sam validate`
