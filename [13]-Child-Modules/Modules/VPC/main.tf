# VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc-cidr
    tags = {
      Name = var.vpc-tag
    }
}

# Subnet-1
resource "aws_subnet" "subnet-1" {
    cidr_block = var.subnet_cidr-1
    availability_zone = var.subnet_az_1
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = var.subnet-1-tag
    }
}

# Subnet-2
resource "aws_subnet" "subnet-2" {
    cidr_block = var.subnet_cidr-2
    availability_zone = var.subnet_az_2
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = var.subnet-2-tag
    }
  
}