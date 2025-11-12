resource "aws_instance" "ec2-instance" {
    ami = "ami-0157af9aea2eef346"
    instance_type = "t2.micro"
    key_name = "spider"
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public.id
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    associate_public_ip_address = true
    user_data = <<-EOF
        #!/bin/bash
        sudo yum install amazon-cloudwatch-agent -y
    EOF

    tags = {
        Name = "EC2-CloudWatch"
    }
}

resource "null_resource" "run_script" {
    depends_on = [ aws_instance.ec2-instance ]

    connection {
        host = aws_instance.ec2-instance.public_ip
        type = "ssh"
        user = "ec2-user"
        private_key = file("C:\\Users\\ACER\\Downloads\\spider.pem")
    }

    provisioner "file" {
        source = "config.json"
        destination = "/tmp/config.json"      
    }
    
    provisioner "remote-exec" {
        inline = [
            "sudo cp /tmp/config.json /opt/aws/amazon-cloudwatch-agent/bin/",
            "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s"
         ]
    }
}