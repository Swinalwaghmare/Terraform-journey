provider "aws" {
  region = "us-east-1"
}

provider "aws" {
    alias = "west"
    region = "us-west-2"
}

resource "aws_vpc" "east_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DB-VPC-East"
  }
}

resource "aws_subnet" "east-subnet-1" {
  vpc_id = aws_vpc.east_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "DB-Subnet-1a"
  }
}

resource "aws_subnet" "east-subnet-2" {
  vpc_id = aws_vpc.east_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "DB-Subnet-1b"
  }
}

resource "aws_db_subnet_group" "east_db_subnet" {
  subnet_ids = [aws_subnet.east-subnet-1.id, aws_subnet.east-subnet-2.id]
  name = "db-subnet"
}

resource "aws_vpc" "west_vpc" {
  provider = aws.west
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DB-VPC-West"
  }
}

resource "aws_subnet" "west-subnet-1" {
  provider = aws.west
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "DB-Subnet-1a"
  }
}

resource "aws_subnet" "west-subnet-2" {
  provider = aws.west
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "DB-Subnet-1b"
  }
}

resource "aws_db_subnet_group" "west_db_subnet" {
  provider = aws.west
  subnet_ids = [aws_subnet.west-subnet-1.id, aws_subnet.west-subnet-2.id]
  name = "db-subnet"
}


# resource "aws_db_instance" "primary" {
#   engine = "mysql"
#   allocated_storage = 20
#   instance_class = "db.t4g.micro"
  
# }

# resource "aws_db_instance" "replica_west" {
#   provider = aws.west
#   identifier = "west-master-db-replica"
#   replicate_source_db = aws_db_instance.primary.id
#   instance_class = 'db.t4.tg'
# }

