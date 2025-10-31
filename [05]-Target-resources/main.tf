provider "aws" {
  
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TF-VPC"
  }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-Subnet-1"
    }
}

resource "aws_instance" "name" {
  subnet_id = aws_subnet.name.id
  ami = "ami-07860a2d7eb515d9a"
  instance_type = "t2.micro"
  tags = {
    Name = "TF-Instance"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "mlops-swinal"
}

# terraform apply \
# > -target=aws_vpc.name \
# > -target=aws_subnet.name \
# > -target=aws_instance.name