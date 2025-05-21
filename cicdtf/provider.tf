# cicdtf/provider.tf

# Configure the AWS provider
provider "aws" {
  region = var.aws_region # Assuming 'aws_region' is defined in variables.tf or passed as a variable
}

# You might also define a 'aws_region' variable in variables.tf if you haven't already:
# variable "aws_region" {
#   description = "The AWS region to deploy resources into."
#   type        = string
#   default     = "ap-south-1" # Or remove default if always passed via CI
# }
