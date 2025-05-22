variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "az" {
  description = "Availability zone for subnet"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}
