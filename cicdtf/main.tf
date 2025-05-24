terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = "~> 1.0"
}

# # IMPORTANT: UNCOMMENT THIS PROVIDER BLOCK!
# provider "aws" {
#   region = var.aws_region # This correctly references the 'aws_region' variable declared in your root variables.tf
# }

module "vpc" {
  source             = "./modules/vpc" # Make sure your vpc module is in cicdtf/modules/vpc/
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  vpc_name           = "myvpc"
  availability_zone  = "ap-south-1a"
}

resource "aws_key_pair" "my_deployer_key" {
  key_name   = "my-deployer-ed25519-key"
  public_key = var.ssh_public_key # This correctly references the 'ssh_public_key' variable declared in your root variables.tf
}

data "aws_ami" "ubuntu" { # Ensure this data source name matches what's used below
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# CORRECTED: module "web" inputs
module "web" {
  source        = "./modules/web"  # Correct module path (make sure your web module is in cicdtf/modules/web/)
  subnet_id     = module.vpc.pb_sn # Correct output name from VPC module (was sn)
  key_name      = aws_key_pair.my_deployer_key.key_name
  instance_name = "myec2"                # This input was missing, and is required by your web/variables.tf
  ami_id        = data.aws_ami.ubuntu.id # Correct input name (was ami), and matches the data source name
  sg            = module.vpc.sg          # Correct output name from VPC module (was sg_id)
}
