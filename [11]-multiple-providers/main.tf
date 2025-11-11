provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    region = "us-west-2"
    alias = "west2"
}

resource "aws_instance" "east-1" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    tags = {
      Name = "east-1"
    }
}

resource "aws_s3_bucket" "west2" {
    bucket = "mlops-swinal"
    provider = aws.west2
  
}