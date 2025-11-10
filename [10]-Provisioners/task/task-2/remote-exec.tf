provider "aws" {
  
}

resource "aws_instance" "name" {

    ami = "ami-0157af9aea2eef346"
    instance_type = "t2.micro"
    key_name = "spider"
    associate_public_ip_address = true

    tags = {
      Name = "SQL Runner"
    }

}

# Deploy SQL
resource "null_resource" "remote-sql-exec" {
    depends_on = [aws_instance.name ]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("C:\\Users\\ACER\\Downloads\\spider.pem")
      host = aws_instance.name.public_ip
    }

    provisioner "file" {
        source = "test.sql"
        destination = "/tmp/test.sql"      
    }

    provisioner "remote-exec" {
        inline = [ 
            "sudo yum install mariadb105-server -y",
            "mysql -h mlops.c0hiae062941.us-east-1.rds.amazonaws.com -u admin -pcloud123 < /tmp/test.sql"
         ]
    }

}