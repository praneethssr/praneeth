terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a compatible AWS provider version
    }
  }
  required_version = "~> 1.0" # Use a compatible Terraform version
}

# provider "aws" {
#   region = var.aws_region
# }

# --- Data Source for AMI (Amazon Linux 2) ---
# This data source finds the latest Amazon Linux 2 AMI for your region
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

# --- Key Pair for SSH Access ---
# Ensure your TF_VAR_PUBLIC_KEY secret in GitHub Actions contains a valid OpenSSH public key.
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key # Comes from TF_VAR_public_key secret
}


# --- Module Calls ---

# 1. VPC Module
module "vpc" {
  source = "./modules/vpc"

  # VPC Configuration
  vpc_cidr_block    = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  vpc_name          = "my-app-vpc"
  aws_region        = var.aws_region # Pass the region to the VPC module
}

# 2. EC2 Instance Module
# CORRECTED: Changed 'ami' to 'ami_id' to match the variable expected by the EC2 module.
module "ec2" {
  source = "./modules/ec2"

  ami_id        = data.aws_ami.amazon_linux_2.id # Corrected argument name
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id # Use the public subnet from the VPC module
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id # Pass the VPC ID to the EC2 module for security group
}

# 3. Web Server Module
module "web" {
  source = "./modules/web"

  ami_id        = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id # Use the public subnet from the VPC module
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyWebServer"
  # You might want to pass vpc_id to the web module if it needs to create security groups etc.
  # vpc_id        = module.vpc.vpc_id
}
