variable "public_key" {
  description = "Public key content for EC2 key pair"
  type        = string
}

variable "instance_az" {
  description = "Availability zone for subnet"
  type        = string
  default     = "ap-south-1a"
}
