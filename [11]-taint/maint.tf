provider "aws" {
  
}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC"
    }
}

resource "aws_subnet" "public-1" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc.id
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-1"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "TF-IG"
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
    tags = {
      Name = "Public-RT"
    }
}

resource "aws_route_table_association" "public-rt-ass" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_security_group" "bastion" {
    name = "bastion"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Allow SSH"
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

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-1.id
    key_name = "spider"
    tags = {
        Name = "taint-instance"
    }
    vpc_security_group_ids = [aws_security_group.bastion.id]
    associate_public_ip_address = true
}

resource "null_resource" "run_script" {

    provisioner "remote-exec" {
        connection {
          host = aws_instance.name.public_ip
          user = "ec2-user"
          private_key = file("C:\\Users\\ACER\\Downloads\\spider.pem")
        }

        inline = [ 
            "echo 'Hello from local to bastion 11-11-25 16:08' >> /tmp/file.txt"
         ]
      
    }

    # triggers = {
    #     always_run = "${timestamp()}" # Forces rerun every time
    # }  
}

# terraform taint null_resource.run_script
# terraform untaint null_resource.run_script