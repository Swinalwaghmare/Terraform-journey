# Copies files or directories from your local machine to the remote resource (e.g., EC2).
provider "aws" {
  
}

data "aws_ami" "amazon" {
    most_recent = true

    filter {
      name = "name"
      values = ["al2023-ami-2023.9.20251105.0-kernel-6.1-x86_64"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
    owners = ["137112412989"]
  
}

resource "aws_instance" "file-exe" {
    ami = data.aws_ami.amazon.id
    instance_type = "t2.micro"
    key_name = "spider"
    associate_public_ip_address = true
    tags = {
      Name = "file-execution"
    }
    
    # Copying a local script inside the ec2
    provisioner "file" {
        source = "file1.txt"
        destination = "/tmp/file1.txt"
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("C:\\Users\\ACER\\Downloads\\spider.pem")
      host = self.public_ip
    }

}

resource "aws_security_group" "name" {
  name = "default"
  description = "default VPC security group"
  vpc_id = "vpc-0f9dababff99ded64"

  ### SSH
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}