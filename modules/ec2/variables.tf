variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from vpc module"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID from vpc module"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}