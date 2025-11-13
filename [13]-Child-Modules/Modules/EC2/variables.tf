variable "ami_id" {
  default = ""
  type = string
  description = "Instance AMI"
}

variable "instance_type" {
  default = ""
  type = string
  description = "Instance type"
}

variable "subnet_id" {
  default = ""
  type = string
  description = "Subnet ID"
}

variable "instance_tag" {
  default = ""
  type = string
  description = "Instance tag"
}