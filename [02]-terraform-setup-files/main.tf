resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Terraform-VPC"
    }
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public1.id
    tags = {
      Name = "Terraform-Instance"
    }
  
}