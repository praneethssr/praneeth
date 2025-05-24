# cicdtf/modules/vpc/variables.tf

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC and its resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region for the VPC."
  type        = string
  default     = "ap-south-1" # Default to ap-south-1, but can be overridden by root main.tf
}
