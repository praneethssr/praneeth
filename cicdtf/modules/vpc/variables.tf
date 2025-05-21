variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_name" {
  type        = string
  default     = "my-vpc"
}

variable "subnet_name" {
  type        = string
  default     = "my-subnet"
}

variable "az" {
  type        = string
  default     = "ap-south-1a"
}

variable "ami" {
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  default     = "my-key"
}

variable "instance_name" {
  type        = string
  default     = "my-ec2"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # or whatever CIDR you want
}
# cicdtf/variables.tf

variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  # You can add a validation rule here if you want to ensure it's a valid SSH key format.
  # For example:
  # validation {
  #   condition     = can(regex("^ssh-(rsa|ed25519|dss|ecdsa) AAAA[0-9A-Za-z+/]+[=]{0,2}( .*|$)", var.public_key))
  #   error_message = "The public_key must be a valid SSH public key string."
  # }
}
