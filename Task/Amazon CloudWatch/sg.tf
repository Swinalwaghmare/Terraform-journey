resource "aws_security_group" "sg" {
    name = "EC2-Connection"
    description = "Allow SSH Connection"
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "EC2-Conn"
    }
    ingress {
        description = "SSH for all"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
