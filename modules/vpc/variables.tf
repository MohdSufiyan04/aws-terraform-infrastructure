variable "vpc_cidr" {
  description = "IP range for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "IP range for the public subnet"
  type        = string
}

variable "environment" {
  description = "Environment name e.g. dev or prod"
  type        = string
}

variable "az" {
  description = "Availability zone e.g. us-east-1a"
  type        = string
}