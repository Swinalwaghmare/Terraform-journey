# Network
vpc-cidr = "10.0.0.0/16"
vpc-tag = "VPC-1"

subnet_cidr-1 = "10.0.1.0/24"
subnet_az_1 = "us-east-1a"
subnet-1-tag = "DB-Subnet-1"

subnet_cidr-2 = "10.0.2.0/24"
subnet_az_2 = "us-east-1b"
subnet-2-tag = "DB-Subnet-2"


# RDS 

db_identifier = "mlops-db"
db_engine = "mysql"
db_instance_class = "db.t3.micro"
db_username = "admin"
db_password = "cloud123"

# EC2
ami_id = "ami-0cae6d6fe6048ca2c"
instance_type = "t2.micro"
instance_tag = "Terraform-EC2"