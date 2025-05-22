variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
}

variable "instance_az" {
  description = "The AWS Availability Zone for the EC2 instance and public subnet."
  type        = string
  default     = "ap-south-1a"
}

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1"
}
