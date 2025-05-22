terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# AWS Provider Configuration
# Defines the cloud provider and the region for resource deployment.
# provider "aws" {
#   region = "ap-south-1"
# }

# VPC Module Call
# This section calls a local module to create the Virtual Private Cloud (VPC)
# and its associated public subnet.
module "vpc" {
  source = "./modules/vpc" # Path to the VPC module

  cidr_block  = "10.0.0.0/16"      # CIDR block for the entire VPC
  vpc_name    = "my-app-vpc"       # Name tag for the VPC
  subnet_cidr = "10.0.1.0/24"      # CIDR block for the public subnet
  az          = "ap-south-1a"      # Availability Zone for the subnet
  subnet_name = "main-public-subnet" # Name tag for the public subnet
}

# Data Source: Latest Amazon Linux 2 AMI
# Dynamically retrieves the ID of the most recent Amazon Linux 2 AMI
# suitable for HVM virtualization and x86_64 architecture.
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

# Variable Declaration: SSH Public Key
# This variable expects the content of an SSH public key, which will be used
# to create an EC2 Key Pair for secure access to instances.
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
}

# Resource: AWS Key Pair
# Creates an SSH key pair in AWS using the public key content provided
# via the 'public_key' variable.
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key" # Name of the key pair in AWS
  public_key = var.public_key    # Content of the public key
}

# EC2 Module Call
# This section calls a local module to provision an EC2 instance,
# integrating it with the previously created VPC and key pair.
module "ec2" {
  source        = "./modules/ec2"
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id

  public_key    = var.public_key   # pass it as 'public_key'
}


