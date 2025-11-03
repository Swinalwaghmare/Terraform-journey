module "name" {
  source = "../main-module"
  vpc_cidr = "10.0.0.0/24"
  vpc_tag_name = "Terraform-VPC"
  subnet_az = "us-east-1a"
  subnet_cidr = "10.0.0.0/28"
  subnet_tag_name = "Public-Subnet-1a"
}