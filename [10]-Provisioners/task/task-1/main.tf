provider "aws" {
  
}

resource "aws_db_instance" "name" {
    instance_class = "db.t3.micro"
    username = "admin"
    password = "cloud123"
    allocated_storage = 20
    db_name = "dev"
    engine = "mysql"
    engine_version = "8.0"
    skip_final_snapshot = true
    publicly_accessible = true
    identifier = "mlops"
    apply_immediately = true
}


# use null_resource to execute the SQL script from our local machine
resource "null_resource" "local_sql_exec" {
    depends_on = [ aws_db_instance.name ]

    provisioner "local-exec" {
      command = "mysql -h ${aws_db_instance.name.address} -u admin -pcloud123 dev < test.sql" 
    }
    triggers = {
      always_run = timestamp() #trigger every time apply 
  }
}