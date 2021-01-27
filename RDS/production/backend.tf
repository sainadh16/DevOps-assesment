terraform {
  backend "s3" {
    bucket          = "test-rds-sai"
    dynamodb_table  = "terraform-state-lock-dynamo"
    encrypt         = true
    key             = "terraformstate/production"
    region          = "us-east-1"
  }
}