# AWS SAM Deployment Documentation

This document explains how to deploy Lambda functions using AWS SAM (Serverless Application Model).

## Prerequisites

Before deploying Lambda functions, ensure you have:

1. AWS CLI installed and configured
2. AWS SAM CLI installed
3. Python 3.9+ installed
4. Appropriate AWS permissions (Lambda and S3 access)

## Local Testing

### Testing Lambda Functions Locally

1. Navigate to the repository root:
   ```bash
   cd lambda-management-repo
   ```

2. Use the provided script to test a function locally:
   ```bash
   ./scripts/local-invoke.sh example-function
   ```

3. To test with a custom event:
   ```bash
   ./scripts/local-invoke.sh example-function events/custom-event.json
   ```

### Running Unit Tests

Run tests for all functions:
```bash
for func_dir in functions/*/; do
  cd "$func_dir"
  python -m pytest tests/ -v
  cd ../../
done
```

## Manual Deployment

### Building the Lambda Functions

Build the Lambda functions using SAM:
```bash
sam build --use-container
```

### Deploying to AWS

Deploy the Lambda functions to AWS:
```bash
sam deploy --guided
```

This will:
1. Package the Lambda functions
2. Upload them to an S3 bucket
3. Deploy the CloudFormation stack
4. Create the necessary resources (Lambda functions, API Gateway, etc.)

### Deployment Parameters

The `samconfig.toml` file contains deployment parameters:
- `stack_name`: Name of the CloudFormation stack
- `s3_bucket`: S3 bucket for deployment artifacts
- `region`: AWS region for deployment
- `capabilities`: IAM capabilities
- `parameter_overrides`: Additional parameters

## Automated Deployment

The repository includes a GitHub Actions workflow for automated deployment:

1. Push changes to the `main` branch
2. GitHub Actions will automatically build and deploy the Lambda functions
3. The workflow will output the API Gateway endpoints for the deployed functions

## Troubleshooting

If deployment fails:

1. Check the SAM CLI output for error messages
2. Verify that AWS credentials are correctly configured
3. Ensure the deployment bucket exists in the specified region
4. Validate the SAM template using `sam validate`

## Cleanup

To remove deployed resources:
```bash
sam delete --stack-name lambda-management-dev
```
