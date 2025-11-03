variable "vpc_cidr" {
    default = "10.0.0.0/24"
    type = string
}

variable "vpc_tag_name" {
    default = "Terraform-VPC-2"
    type = string
}

variable "subnet_az" {
    default = "us-east-1b"
    type = string
}

variable "subnet_cidr" {
    default = "10.0.0.0/28"
    type = string  
}

variable "subnet_tag_name" {
    default = "public-subnet-1b"
    type = string
}

