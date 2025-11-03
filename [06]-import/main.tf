resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-0bdd88bd06d16ba03"
    tags = {
        Name = "terraform-ec2"
    }
  
}

resource "aws_s3_bucket" "name" {
  bucket = "mlops-swinal"
}

#example command terraform import aws_instance.name i-0f805ae729b101f2f