resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC-Developer2"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "TF-Subnet-1"
  }
}

resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    tags = {
      Name = "Developer-1-Instance"
    }
}