variable "vpc_cidr" {
  description = "VPC CIDR block"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_tag_name" {
    description = "VPC tag name"
    type = string
    default = "VPC-1"
}

variable "subnet_az" {
    description = "subnet availability zone"
    type = string
    default = "us-east-1"
}

variable "subnet_cidr" {
    description = "subnet cidr block"
    type = string
    default = "10.0.1.0/24"
}

variable "subnet_tag_name" {
  description = "Subnet tag name"
  type = string
  default = "Public-1"
}