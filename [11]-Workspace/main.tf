resource "aws_s3_bucket" "name" {
    bucket = "mlops-swinal-${terraform.workspace}"
}
