variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
}
