variable "subnet_ids" {
    type = list(string)
    description = "Private-Subnet-IDS"  
}

variable "db_identifier" {
    type = string
    description = "database identifie" 
}

variable "db_engine" {
    type = string
    description = "database engine" 
}

variable "db_instance_class" {
    type = string
    description = "database instance class" 
}

variable "db_username" {
    type = string
    description = "database username" 
}

variable "db_password" {
    type = string
    description = "database password" 
  
}