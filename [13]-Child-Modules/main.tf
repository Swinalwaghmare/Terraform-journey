provider "aws" {
  
}

module "network" {
    source = "./Modules/VPC"
    vpc-cidr = var.vpc-cidr
    vpc-tag = var.vpc-tag

    subnet_cidr-1 = var.subnet_cidr-1
    subnet_az_1 =  var.subnet_az_1
    subnet-1-tag = var.subnet-1-tag 

    subnet_cidr-2 = var.subnet_cidr-2
    subnet_az_2 = var.subnet_az_2
    subnet-2-tag = var.subnet-2-tag
}

module "rds" {
    source = "./Modules/RDS"
    
    subnet_ids = [module.network.subnet-1, module.network.subnet-2]
    
    db_identifier = var.db_identifier
    db_engine = var.db_engine
    db_instance_class = var.db_instance_class
    db_username = var.db_username
    db_password = var.db_password
}

module "ec2" {
    source = "./Modules/EC2"

    subnet_id = module.network.subnet-1
    ami_id = var.ami_id
    instance_type = var.instance_type
    instance_tag = var.instance_tag

}