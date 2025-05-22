# This variable will receive the SSH public key from the GitHub Actions workflow.
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  # Optional validation
  # validation {
  #   condition     = can(regex("^ssh-(rsa|ed25519|dss|ecdsa) AAAA[0-9A-Za-z+/]+[=]{0,2}( .*|$)", var.public_key))
  #   error_message = "The public_key must be a valid SSH public key string (e.g., ssh-rsa AAAA...)."
  # }
}

# AWS region variable used in provider.tf
variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1"
}

# Availability Zone for subnet/instance
variable "instance_az" {
  description = "The AWS Availability Zone for the EC2 instance and public subnet."
  type        = string
  default     = "ap-south-1a"
}

# VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDR block
variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# EC2 instance name tag
variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "MyEC2Instance"
}
