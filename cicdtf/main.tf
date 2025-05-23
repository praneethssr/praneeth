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
<<<<<<< HEAD

# provider "aws" {
#   region = "ap-south-1"
# }

variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  sensitive   = true
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key.pub"
  public_key = var.public_key
}

=======
# --------------------------
# SSH Public Key Variable (REQUIRED for aws_key_pair)
# --------------------------
variable "public_key" {
  description = "The SSH public key content for the EC2 Key Pair."
  type        = string
  sensitive   = true # Mark as sensitive to prevent logging its value
}

# --------------------------
# AWS EC2 Key Pair Resource (REQUIRED for aws_key_pair.deployer_key)
# --------------------------
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = file("C:/Users/admin/.ssh/my-deployer-key.pub")
}

# --------------------------
# VPC Module (REQUIRED for module.vpc)
# --------------------------
>>>>>>> f458e3199351657429f857c20a630cada0c938e7
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  vpc_name     = "my-app-vpc"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a"
  subnet_name  = "main-public-subnet"
}

<<<<<<< HEAD
=======
# --------------------------
# AWS AMI Data Source (REQUIRED for data.aws_ami.amazon_linux_2)
# --------------------------
>>>>>>> f458e3199351657429f857c20a630cada0c938e7
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

module "ec2" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.amazon_linux_2.id
<<<<<<< HEAD
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.id
  instance_name  = "MyEC2Instance"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
}
=======
  instance_type  = "t2.micro" # Free tier eligible instance type
  key_name       = aws_key_pair.deployer_key.key_name
  instance_name  = "MyEC2Instance" # Name for the EC2 instance
  vpc_id         = module.vpc.vpc_id # Pass VPC ID from the VPC module
  subnet_id      = module.vpc.public_subnet_id # Pass subnet ID from the VPC module
}

# --------------------------
# Outputs for convenience (Assuming you want these at the root level)
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
>>>>>>> f458e3199351657429f857c20a630cada0c938e7
