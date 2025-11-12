provider "aws" {
  
}

# create a vpc
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC"
    }
  
}

# create subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-Subnet"
    }
}

# create internet gateway
resource "aws_internet_gateway" "TF-IG" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "TF-IG"
    }  
}

# create route table
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF-IG.id
    }
    tags = {
      Name = "Public-RT"
    }
}

# create route table assosication
resource "aws_route_table_association" "public_rt_ass" {
    route_table_id = aws_route_table.public-rt.id
    subnet_id = aws_subnet.public.id  
}