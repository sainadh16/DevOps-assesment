provider "aws" {
    profile = "default"
    region = "us-east-1"
}

# terraform {
#   required_providers {
#     archive = {
#       source = "hashicorp/archive"
#       version = "1.3.0"
#     }
#     aws = {
#       region                  = "us-east-1"
#       profile                 = "default"
#     }
# }