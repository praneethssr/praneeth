# cicdtf/main.tf

# Define the EC2 Key Pair by reading the public key content from a file.
# This file will be created on the fly by your GitHub Actions workflow.
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key" # Consistent name from previous discussion
  public_key = file("public_key_from_secret.pub") # Read the content from the file
}

# 1. AWS AMI Data Source
# Dynamically discovers the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Example of how you might call your modules
# Ensure your modules are correctly defined in the 'modules' directory
# and accept necessary inputs.

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  vpc_name    = "my-app-vpc"
  subnet_cidr = "10.0.1.0/24"
  az          = var.instance_az # Assuming this comes from cicdtf/variables.tf
  subnet_name = "main-public-subnet"
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
}

# The AWS provider configuration and backend configuration would typically
# be in separate files (e.g., provider.tf and backend.tf) or directly in this main.tf.
# For simplicity, if not using separate files:
provider "aws" {
  region = var.aws_region # Assuming this comes from cicdtf/variables.tf
}

# Backend configuration example
terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket-name" # Replace with your S3 bucket name
    key            = "cicdtf/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    # dynamodb_table = "your-terraform-locks-table" # Optional: for state locking
  }
}
