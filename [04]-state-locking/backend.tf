terraform {
  backend "s3" {
    bucket = "mlops-swinal"
    key = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}