###########################################
# AWS Provider Configuration
###########################################
provider "aws" {
  # Uses default AWS CLI credentials and region
  # You can also specify region like:
  # region = "us-east-1"
}

###########################################
# S3 Bucket Creation
###########################################
resource "aws_s3_bucket" "name" {
  # Creates an S3 bucket to store the Lambda deployment package
  bucket = "mlops-swinal"     # Must be globally unique across all AWS accounts
}

###########################################
# Upload Lambda Deployment Package to S3
###########################################
resource "aws_s3_object" "lambda-file" {
  # Uploads your Lambda ZIP file to the above S3 bucket
  bucket = aws_s3_bucket.name.id
  key = "lambda_function.zip"   # The name/path of the object inside the bucket
  source = "lambda_function.zip"  # Local file path on your machine
  etag = filemd5("lambda_function.zip")  # Ensures Terraform re-uploads if file changes
}

###########################################
# IAM Role for Lambda Execution
###########################################
resource "aws_iam_role" "lambda-role" {
  # Uploads your Lambda ZIP file to the above S3 bucket
  name = "lambda_execution_role"

  # This is the "trust policy" that defines who can assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole" # Allows assuming the role via STS
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com" # AWS Lambda service can assume this role
            }
        }]
  }) 
}

###########################################
# Attach IAM Policy: Basic Lambda Execution
###########################################
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  # Grants permissions for writing logs to CloudWatch
  role = aws_iam_role.lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

###########################################
# Attach IAM Policy: Read-only S3 Access
###########################################
resource "aws_iam_role_policy_attachment" "allow_s3" {
  # Grants read-only access to all S3 buckets (optional)
  # Useful if Lambda needs to read data from S3 during execution
  role = aws_iam_role.lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

###########################################
# Lambda Function Definition
###########################################
resource "aws_lambda_function" "lambda-s3" {
  # Creates a Lambda function using the deployment package stored in S3
  function_name = "s3-lambda" # Name of your Lambda function in AWS Console
  role = aws_iam_role.lambda-role.arn
  runtime = "python3.13"      # Python runtime version
  handler = "lambda_function.lambda_handler"
  # The handler refers to the function in your code (file.function_name)
  # Example: lambda_function.py → lambda_handler(event, context)

  # Specifies that the code is stored in S3 (not uploaded directly)
  s3_bucket = aws_s3_bucket.name.id
  s3_key = "lambda_function.zip"

  # Resource configuration
  memory_size = 128
  timeout = 900
}