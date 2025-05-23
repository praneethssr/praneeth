# modules/ec2/variables.tf

variable "ami" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = string
}