variable "ami" {
  type        = string
  default     = ""
  description = "AMI ID (optional). If empty, Amazon Linux 2 will be used."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Optional: existing EC2 key pair name"
}

variable "public_key" {
  type        = string
  default     = ""
  description = "Optional: public key content to create a new EC2 key pair"
}

variable "instance_name" {
  type        = string
  description = "Tag name for the EC2 instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}
