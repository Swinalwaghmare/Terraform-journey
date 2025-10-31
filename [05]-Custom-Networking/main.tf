# VPC Creation
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC"
    }  
}

# Internet Gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "TF_IG"
    }
}

# Public Subnet Creation
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-Subnet-1"
    }
}

# Private Subnet Creation
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Private-Subnet"
    }
}

# Route Table
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "Public-RT"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id        
    }
}

# Create subnet association
resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.name.id
}

# Create Security Group
resource "aws_security_group" "name" {
  name = "allow_tls"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "dev-sg"
  }

  ingress {
  description = "HTTP"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Servers
resource "aws_instance" "public" {
  ami = "ami-07860a2d7eb515d9a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    Name = "Public-EC2"
  }
}

resource "aws_instance" "private" {
  ami = "ami-07860a2d7eb515d9a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.name.id]
  tags = {
    Name = "Private-EC2"
  }
}

# Create Elastic IP
resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

# Create NAT 
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "TF-NAT"
  }
  depends_on = [ aws_internet_gateway.name ]
}

# Create RT
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-RT"
  }  
}

# Route Table Association
resource "aws_route_table_association" "pvt_association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}