resource "aws_db_subnet_group" "db_subnet_group" {
    subnet_ids = var.subnet_ids
    name = "${var.db_identifier}-subnet-group"
    tags = {
        Name = "${var.db_identifier}-subnet-group"
    }
}

resource "aws_db_instance" "db" {
    identifier = var.db_identifier
    engine = var.db_engine
    instance_class = var.db_instance_class
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
    username = var.db_username
    password = var.db_password
    skip_final_snapshot = true
}