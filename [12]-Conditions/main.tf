# Example - 1
variable "aws_region" {
    description = "The region in which to create the infrastructure"
    type = string
    nullable = true
    default = "us-east-1"
    validation {
      condition = var.aws_region == "us-east-1" || var.aws_region == "eu-west-1"
      error_message = "The variable 'aws_region' must be one of the following regions: us-east-1, eu-west-1"
    }
}

provider "aws" {
    
}

resource "aws_s3_bucket" "name" {
    bucket = "mlops-swinal-${var.aws_region}"
  
}

# ------------------------------------------------------------------------------------------------------------------#

# Example - 2

variable "create_bucket" {
    type = bool
    default = true
}

resource "aws_s3_bucket" "name" {
    count = var.create_bucket ? 1 : 0
    bucket = "mlops-swinal"
  
}

# ------------------------------------------------------------------------------------------------------------------#

# Example - 3

variable "environment" {
    type = bool
    default = true  
}

resource "aws_instance" "name" {
    count  = var.environment == "prod" ? 3:1
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"

    tags = {
      Name = "example-${count.index}"
    }
}

# Example 4

variable "environment" {
    type = string
    default = "prod"  
}

resource "aws_instance" "name" {
    count  = var.environment == "prod" ? 3:1
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"

    tags = {
      Name = "example-${count.index}"
    }
}