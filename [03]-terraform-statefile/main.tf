resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = var.instance_type
    tags = {
      Name = "TF-Instance"
    }
}