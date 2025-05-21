# cicdtf/main.tf

# The AWS provider configuration has been moved to provider.tf to avoid duplication.
# If you remove provider.tf, you would place the provider block here.

# Define the EC2 Key Pair using the public_key variable
# This resource will create an SSH key pair in AWS.
resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key" # The name of the key pair in AWS
  public_key = var.public_key # Use the public_key passed from the workflow
}

# Example of how you might call your modules
# Ensure your modules are correctly defined in the 'modules' directory
# and accept necessary inputs.

# module "vpc" {
#   source = "./modules/vpc"
#   # Pass necessary variables to your VPC module
#   # vpc_cidr_block = var.vpc_cidr_block
# }

# module "ec2" {
#   source = "./modules/ec2"
#   # Pass necessary variables to your EC2 module, including the key pair name
#   # vpc_id        = module.vpc.vpc_id # Example: Output from your VPC module
#   # instance_type = var.instance_type
#   # key_name      = aws_key_pair.deployer_key.key_name
# }

# Example of backend configuration in main.tf (or a separate backend.tf)
# If you are using tfstate.config for backend configuration via -backend-config,
# you typically don't embed the backend block directly here unless you want
# to clear the "Missing backend configuration" warning.
/*
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket" # Replace with your S3 bucket name
    key            = "path/to/your/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "your-terraform-locks-table" # Replace with your DynamoDB table name for state locking
  }
}
*/
