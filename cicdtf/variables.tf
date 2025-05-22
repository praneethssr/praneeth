variable "public_key" {
  description = "Public key content for EC2 key pair"
  type        = string
}

variable "instance_az" {
  description = "Availability zone for subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "ap-south-1"
}
