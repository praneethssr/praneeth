# cicdtf/main.tf

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
#   region = "ap-south-1" # Ensure this is set to your desired AWS region
# }

# --------------------------
# SSH Public Key Variable
# --------------------------
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  sensitive   = true
}

# --------------------------
# AWS EC2 Key Pair Resource
# --------------------------
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key" # Name your key pair in AWS
  public_key = var.public_key   # This references the variable
}

# --------------------------
# VPC Module
# --------------------------
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  vpc_name     = "my-app-vpc"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a" # Ensure this AZ is valid for your chosen region
  subnet_name  = "main-public-subnet"
}

# --------------------------
# AWS AMI Data Source
# --------------------------
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

# --------------------------
# EC2 Module
# --------------------------
module "ec2" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.amazon_linux_2.id
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.deployer_key.key_name
  instance_name  = "MyEC2Instance"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
}

# --------------------------
# Web Module (placeholder)
# Add required inputs here if it needs any.
# For now, ensure the module directory and its main.tf are valid.
# --------------------------
module "web" {
  source = "./modules/web"
  # Example: If your web module needs the EC2 instance ID or IP
  # instance_id = module.ec2.instance_id
  # instance_public_ip = module.ec2.instance_public_ip
}

# --------------------------
# Outputs for convenience
# --------------------------
output "ec2_public_ip" {
  description = "The public IP address of the created EC2 instance."
  value       = module.ec2.instance_public_ip
}

output "ec2_private_ip" {
  description = "The private IP address of the created EC2 instance."
  value       = module.ec2.instance_private_ip
}

output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = module.ec2.instance_id
}