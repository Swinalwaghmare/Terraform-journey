locals {
  bucket_name = "mlops-swinal"
  enviroment = "dev"
}

resource "aws_s3_bucket" "name" {
    bucket = local.bucket_name
    tags = {
      Name = local.bucket_name
      Enviroment = local.enviroment
    }

}