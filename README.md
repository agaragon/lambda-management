# AWS Lambda Management Repository

This repository provides a streamlined workflow for creating, testing, and deploying AWS Lambda functions using AWS SAM (Serverless Application Model) and GitHub Actions.

## Features

- Simplified Lambda function creation with Python templates
- Automated deployment to AWS using GitHub Actions
- Secure credential management using GitHub Secrets
- Local development and testing support
- Standardized project structure for consistency

## Repository Structure

```
lambda-management-repo/
├── .github/
│   └── workflows/
│       └── deploy.yml       # GitHub Actions workflow for deployment
├── functions/               # Directory for all Lambda functions
│   └── example-function/    # Example Lambda function
│       ├── src/             # Source code
│       │   └── app.py       # Lambda handler
│       ├── tests/           # Unit tests
│       │   └── test_app.py  # Test for Lambda handler
│       └── requirements.txt # Python dependencies
├── scripts/                 # Helper scripts
│   ├── create-function.sh   # Script to create new Lambda function
│   └── local-invoke.sh      # Script to invoke Lambda locally
├── .gitignore               # Git ignore file
├── README.md                # This file
├── samconfig.toml           # SAM CLI configuration
└── template.yaml            # SAM template for Lambda resources
```

## Getting Started

### Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/) installed and configured
- [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) installed
- [Python 3.9+](https://www.python.org/downloads/) installed
- [Git](https://git-scm.com/downloads) installed

### Setup

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/lambda-management-repo.git
   cd lambda-management-repo
   ```

2. Set up GitHub Secrets for AWS credentials:
   - Go to your GitHub repository
   - Navigate to Settings > Secrets and variables > Actions
   - Add the following secrets:
     - `AWS_ACCESS_KEY_ID`: Your AWS access key
     - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
     - `AWS_REGION`: Your preferred AWS region (e.g., us-east-1)

### Creating a New Lambda Function

Use the provided script to create a new Lambda function:

```bash
./scripts/create-function.sh my-new-function
```

This will:
1. Create a new function directory with the required structure
2. Add the function to the SAM template
3. Set up basic tests

### Local Development

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

4. Test locally using the SAM CLI:
   ```bash
   sam local invoke
   ```

### Deployment

Deployments are automated via GitHub Actions. Simply push your changes to the main branch:

```bash
git add .
git commit -m "Add new function"
git push origin main
```

The GitHub Actions workflow will:
1. Build your Lambda functions
2. Package them with dependencies
3. Deploy to AWS using SAM

## Security Best Practices

- Never commit AWS credentials to the repository
- Use GitHub Secrets for storing sensitive information
- Regularly rotate your AWS access keys
- Follow the principle of least privilege for IAM roles

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
