terraform {
  backend "s3" {
    bucket          = "awsconfig-shthalla"
    dynamodb_table  = "terraform-state-lock"
    encrypt         = true
    key             = "RDS-terraform/developement"
    region          = "us-east-1"
  }
}