# This file calls all 3 modules we built
# Think of it like assembling the LEGO blocks together

terraform {
  backend "s3" {
    bucket       = "mohd-sufiyan-tf-state"
    key          = "prod/terraform.tfstate"   # separate state file for dev
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Calling VPC module — building the network
module "vpc" {
  source      = "../../modules/vpc"   # path to our vpc module
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  az          = var.az
}

# Calling EC2 module — building the server
# Notice how we pass vpc outputs directly into ec2
# vpc_id and subnet_id come FROM the vpc module we just called above
module "ec2" {
  source        = "../../modules/ec2"
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id        # output from vpc module
  subnet_id     = module.vpc.subnet_id     # output from vpc module
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name
}

# Calling S3 module — building app storage
module "s3" {
  source      = "../../modules/s3"
  environment = var.environment
  app_name    = var.app_name
}