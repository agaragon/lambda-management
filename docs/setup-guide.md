# Lambda Management Repository - Setup Guide

This document provides a comprehensive guide to setting up and using the Lambda Management Repository.

## Introduction

The Lambda Management Repository is designed to streamline the process of creating, testing, and deploying AWS Lambda functions using AWS SAM (Serverless Application Model) and GitHub Actions. This guide will walk you through the setup process and explain how to use the repository effectively.

## Repository Setup

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/lambda-management-repo.git
cd lambda-management-repo
```

### 2. Configure GitHub Secrets

To enable automated deployments, you need to set up GitHub Secrets:

1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - `AWS_REGION`: Your preferred AWS region (e.g., us-east-1)
   - `DEPLOYMENT_BUCKET`: (Optional) S3 bucket for deployment artifacts

### 3. Install Required Tools

Ensure you have the following tools installed:

- [AWS CLI](https://aws.amazon.com/cli/)
- [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- [Python 3.9+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

## Using the Repository

### Creating a New Lambda Function

Use the provided script to create a new Lambda function:

```bash
./scripts/create-function.sh my-new-function
```

This will:
1. Create a new function directory with the required structure
2. Add the function to the SAM template
3. Set up basic tests

### Local Development and Testing

1. Navigate to your function directory:
   ```bash
   cd functions/my-function
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Test locally using the provided script:
   ```bash
   cd ../..
   ./scripts/local-invoke.sh my-function
   ```

### Deploying Lambda Functions

#### Automated Deployment

Simply push your changes to the main branch:

```bash
git add .
git commit -m "Add new function"
git push origin main
```

The GitHub Actions workflow will automatically build and deploy your Lambda functions.

#### Manual Deployment

If you prefer to deploy manually:

```bash
sam build --use-container
sam deploy --guided
```

## Repository Structure

```
lambda-management-repo/
├── .github/workflows/       # GitHub Actions workflows
├── docs/                    # Documentation
├── functions/               # Lambda functions
├── scripts/                 # Helper scripts
├── .gitignore               # Git ignore file
├── README.md                # Main README
├── samconfig.toml           # SAM CLI configuration
└── template.yaml            # SAM template
```

## Best Practices

1. **Security**: Never commit AWS credentials to the repository
2. **Testing**: Write comprehensive tests for your Lambda functions
3. **Documentation**: Document your Lambda functions and their APIs
4. **Dependencies**: Keep dependencies up to date
5. **Monitoring**: Set up monitoring and logging for your Lambda functions

## Troubleshooting

If you encounter issues:

1. Check the GitHub Actions logs for error messages
2. Verify that AWS credentials are correctly set up
3. Ensure the deployment bucket exists in the specified region
4. Validate the SAM template using `sam validate`

## Additional Resources

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [AWS SAM Documentation](https://docs.aws.amazon.com/serverless-application-model/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Support

If you need assistance, please open an issue in the GitHub repository.
