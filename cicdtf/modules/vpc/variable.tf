# This file is located in the 'cicdtf/modules/vpc/' directory.

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "vpc_name" {
  description = "The name tag for the VPC."
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the public subnet."
  type        = string
}
