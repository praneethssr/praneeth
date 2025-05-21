# cicdtf/variables.tf

# This variable will receive the SSH public key from the GitHub Actions workflow.
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  # Optional: Add validation to ensure the input is a valid SSH key format.
  # validation {
  #   condition     = can(regex("^ssh-(rsa|ed25519|dss|ecdsa) AAAA[0-9A-Za-z+/]+[=]{0,2}( .*|$)", var.public_key))
  #   error_message = "The public_key must be a valid SSH public key string (e.g., ssh-rsa AAAA...). Ensure it's not a file path."
  # }
}

# Declaring the aws_region variable for use in provider.tf
variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  # You can set a default value here, or ensure it's always passed via CI/CD.
  default     = "ap-south-1"
}

# Define other variables your configuration might need, e.g., for VPC, EC2 instance type, etc.
# Example:
# variable "vpc_cidr_block" {
#   description = "CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "instance_type" {
#   description = "EC2 instance type"
#   type        = string
#   default     = "t2.micro"
# }
