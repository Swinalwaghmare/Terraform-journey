provider "aws" {
  
}

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    associate_public_ip_address = true
    instance_type = "t2.micro"
    tags = {
      Name = "EC2-Instance"
    }
    # lifecycle {
    #   create_before_destroy = true
    # }
    # lifecycle {
    #   ignore_changes = [ tags ]
    # }
    # lifecycle {
    #   prevent_destroy = true
    # }
}



