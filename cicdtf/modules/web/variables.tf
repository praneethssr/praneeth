# This file is located in the 'cicdtf/modules/web/' directory.

variable "subnet_id" {
  description = "The ID of the subnet to deploy the EC2 instance into."
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to associate with the EC2 instance."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
}

# NEW: Declare the ami_id variable
variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

# Ensure 'sg' is also declared for the security group ID
variable "sg" {
  description = "The ID of the security group to associate with the EC2 instance."
  type        = string
}
