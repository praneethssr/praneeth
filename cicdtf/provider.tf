# Declares the aws_region variable for use in the provider block.
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1" # Set your desired default region here (e.g., "us-east-1", "ap-south-1")
}
