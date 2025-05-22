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
#   region = "ap-south-1"
# }

# VPC Module
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  vpc_name     = "my-app-vpc"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a"
  subnet_name  = "main-public-subnet"
}

# Get latest Amazon Linux 2 AMI
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

# SSH Public Key variable
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
}

# Create AWS Key Pair
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key
}

# EC2 Module
module "ec2" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.amazon_linux_2.id
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.deployer_key.key_name
  instance_name  = "MyEC2Instance"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
}
