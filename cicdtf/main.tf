terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# AWS Provider
# Defines the cloud provider and the region for resource deployment.
# provider "aws" { # This line is now uncommented
#   region = "ap-south-1"
# }

# --------------------------
# VPC Module
# --------------------------
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  vpc_name     = "my-app-vpc"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a"
  subnet_name  = "main-public-subnet"
}

# --------------------------
# SSH Public Key variable
# --------------------------
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  # Removed: default = file("C:\\Users\\admin\\.ssh\\my-deployer-key.pub")
  # The public_key should be provided via a .tfvars file, CLI, or environment variable (e.g., TF_VAR_public_key in CI/CD).
}

# --------------------------
# AWS Key Pair Resource
# --------------------------
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key
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
