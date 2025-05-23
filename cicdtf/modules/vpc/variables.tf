variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "az" {
  description = "The Availability Zone for the public subnet."
  type        = string
}

variable "subnet_name" {
  description = "The name of the public subnet."
  type        = string
<<<<<<< HEAD
}
=======
}
>>>>>>> d2309e1256bce4d47c67cb4f0c3b3561f22e957a
