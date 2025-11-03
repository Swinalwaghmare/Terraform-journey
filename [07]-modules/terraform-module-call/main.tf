resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_tags
    }
}

resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  availability_zone = var.subnet_az
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.subnet_tags
  }
}




module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_instance_name

  instance_type = var.ec2_instance_type
  monitoring    = true
  subnet_id = aws_subnet.name.id
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}