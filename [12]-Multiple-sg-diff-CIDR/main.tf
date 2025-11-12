variable "allowed_ports" {
    type = map(string)
    default = {
      22    = "115.97.164.48/32"
      80    = "0.0.0.0/0"
      443   = "0.0.0.0/0"
      8080  = "10.0.0.0/16" 
      9000  = "192.168.1.0/24"
      3389  = "10.0.1.0/24"
      
    }
  
}

resource "aws_security_group" "my-sg" {
  name = "Diff-CIDR-SG"
  description = "Allow restricted inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow acces to port ${ingress.key}"
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = [ingress.value]
     
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "Diff-CIDR-SG"
  }
}