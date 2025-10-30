terraform {
  backend "s3" {
    bucket = "mlops-swinal"
    key = "terraform/terraform.tfstate"
    # use_lockfile = true # to use s3 native locking 1.19 version above
    region = "us-east-1"
    dynamodb_table = "swinal"
    encrypt = true
  }
}