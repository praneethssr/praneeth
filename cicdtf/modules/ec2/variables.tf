# cicdtf/modules/ec2/variables.tf

variable "ami_id" {
  description = "The ID of the AMI for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the EC2 instance."
  type        = string
}

variable "key_name" {
  description = "The key pair name for the EC2 instance."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}
