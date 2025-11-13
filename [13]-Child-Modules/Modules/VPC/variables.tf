variable "vpc-cidr" {
    default = ""
    type = string
    description = "CIDR block of VPC"
}

variable "vpc-tag" {
    default = ""
    type = string
    description = "Tag Name of VPC"
}

variable "subnet_cidr-1" {
    default = ""
    type = string
    description = "CIDR of Subnet-1"
  
}

variable "subnet_az_1" {
    default = ""
    type = string
    description = "Availabilty zone of Subnet-1"
  
}

variable "subnet-1-tag" {
    default = ""
    type = string
    description = "Tag Name of Subnet-1"
  
}

variable "subnet_cidr-2" {
    default = ""
    type = string
    description = "CIDR of Subnet-1"
  
}

variable "subnet_az_2" {
    default = ""
    type = string
    description = "Availabilty zone of Subnet-1"
  
}

variable "subnet-2-tag" {
    default = ""
    type = string
    description = "Tag Name of Subnet-1"
  
}