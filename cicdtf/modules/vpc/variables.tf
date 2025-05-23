# modules/vpc/variables.tf

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name tag for the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "az" {
  description = "The availability zone for the public subnet."
  type        = string
}

variable "subnet_name" {
  description = "The name tag for the public subnet."
  type        = string
}