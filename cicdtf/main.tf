terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# provider "aws" {
#   region = "ap-south-1" # Set your desired AWS region here
# }

# --------------------------
# SSH Public Key Variable
# --------------------------
# VPC Module
# --------------------------
module "vpc" {
  source       = "./modules/vpc" # Path to your VPC module
  cidr_block   = "10.0.0.0/16"
  vpc_name     = "my-app-vpc"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a" # Ensure this AZ is valid for your chosen region (ap-south-1)
  subnet_name  = "main-public-subnet"
}

# --------------------------
# AWS AMI Data Source
# --------------------------
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] # Official Amazon AMIs

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filters for Amazon Linux 2 AMI
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --------------------------
# EC2 Module
# --------------------------
module "ec2" {
  source         = "./modules/ec2" # Path to your EC2 module
  ami            = data.aws_ami.amazon_linux_2.id
  instance_type  = "t2.micro" # Free tier eligible instance type
  key_name       = aws_key_pair.deployer_key.key_name
  instance_name  = "MyEC2Instance"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
}

# --------------------------
# Outputs for convenience
# --------------------------
<<<<<<< HEAD
# output "ec2_public_ip" {
#   description = "The public IP address of the created EC2 instance."
#   value       = module.ec2.instance_public_ip
# }

# output "ec2_private_ip" {
#   description = "The private IP address of the created EC2 instance."
#   value       = module.ec2.instance_private_ip
# }
=======
output "ec2_public_ip" {
  description = "The public IP address of the created EC2 instance."
  value       = module.ec2.instance_public_ip
}

output "ec2_private_ip" {
  description = "The private IP address of the created EC2 instance."
  value       = module.ec2.instance_private_ip
}
