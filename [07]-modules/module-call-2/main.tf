module "name" {
  source = "../main-module"
  vpc_cidr = var.vpc_cidr
  vpc_tag_name = var.vpc_tag_name
  subnet_az = var.subnet_az
  subnet_cidr = var.subnet_cidr
  subnet_tag_name = var.subnet_tag_name
}
