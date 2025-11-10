# 
provider "aws" {
  
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-Subnet-1"
    }
}

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "TF-IG"
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.name.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
    tags = {
        Name = "public-rt"
    }
  
}

resource "aws_route_table_association" "public-rt-ass" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_security_group" "name" {
    name = "EC2-Connection"
    description = "Allow SSH Connection"
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "SSH"
    }
    ingress{
        description = "SSH for all"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "ec2" {
  ami = "ami-0157af9aea2eef346"
  instance_type = "t2.micro"
  key_name = "spider"
  vpc_security_group_ids = [aws_security_group.name.id]
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [ 
        "mkdir dev",
        "touch dev/file1.txt"
     ]
    
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("C:\\Users\\ACER\\Downloads\\spider.pem")
      host = self.public_ip
    }
  }
}