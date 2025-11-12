provider "aws" {
  
}

# resource "aws_instance" "name" {
#     ami = "ami-0cae6d6fe6048ca2c"
#     instance_type = "t3.micro"
#     count = 2
#     tags = {
#         Name = count.index
#     }

# }

variable "env" {
    type = list(string)
    default = [ "dev", "test" ]
}

resource "aws_instance" "name" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    count = length(var.env)
    tags = {
      Name = var.env[count.index]
    }
  
}