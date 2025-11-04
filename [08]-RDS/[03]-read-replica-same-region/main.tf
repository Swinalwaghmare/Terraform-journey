provider "aws" {
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DB-VPC"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "DB-Subnet-1a"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "DB-Subnet-1b"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  name = "db-subnet"
}


resource "aws_db_instance" "primary" {
    engine = "mysql"
    engine_version = "8.0.42"
    db_name = "masterdb"
    username = "admin"
    password = "admin123"
    instance_class = "db.t4g.micro"
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.db_subnet.id
    availability_zone = "us-east-1a"
    parameter_group_name = "default.mysql8.0"
    identifier = "master-db"
    skip_final_snapshot = true
    tags = {
      Name = "Master-DB"
    }

    # required for replicas
    backup_retention_period = 7
    backup_window = "03:00-04:00"
    apply_immediately = true
}

resource "aws_db_instance" "replica" {
    identifier = "master-db-replica"
    replicate_source_db = aws_db_instance.primary.arn # line which creates replica
    instance_class = "db.t3.micro"
    db_subnet_group_name = aws_db_subnet_group.db_subnet.id 
    availability_zone = "us-east-1b" # 
    skip_final_snapshot = true
    apply_immediately = true

    depends_on = [ aws_db_instance.primary ]
}