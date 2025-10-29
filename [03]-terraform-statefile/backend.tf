terraform {
    backend "s3" {
        bucket = "swinal-terraform-state-file"
        key = "Day3/terraform.tfstate"
        region = "us-east-1"
    }
}