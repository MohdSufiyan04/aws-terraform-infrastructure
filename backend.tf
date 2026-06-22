# This file tells Terraform:
# "Don't store state on my laptop — store it in S3"
# Every module we build from now on will use this backend

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # official AWS provider from HashiCorp
      version = "~> 5.0"         # use version 5.x — stable and modern
    }
  }

  backend "s3" {
    bucket         = "mohd-sufiyan-tf-state"   # the bucket we just created
    key            = "global/terraform.tfstate" # path inside bucket where state is saved
    region         = "us-east-1"
    use_lockfile = true          # the lock table we just created
    encrypt        = true                       # encrypt state at rest
  }
}

# This tells Terraform which AWS region to create everything in
provider "aws" {
  region = "us-east-1"
}