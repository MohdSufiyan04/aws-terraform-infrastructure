variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC IP range"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet IP range"
  type        = string
}

variable "az" {
  description = "Availability zone"
  type        = string
}

variable "instance_type" {
  description = "EC2 size"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}