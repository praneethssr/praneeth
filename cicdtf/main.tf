terraform {
  backend "s3" {
    bucket  = "terraform-state-ssr123-ap-south-1"   # Your existing S3 bucket
    key     = "cicdtf/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # dynamodb_table = "your-terraform-locks-table" # Optional for locking
  }
}

variable "public_key" {
  description = "Public key content for EC2 key pair"
  type        = string
}

variable "instance_az" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "ap-south-1a"
}

# Create the EC2 Key Pair in AWS using the provided public key
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key
}

# Find the latest Amazon Linux 2 AMI
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

# VPC Module
module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  vpc_name    = "my-app-vpc"
  subnet_cidr = "10.0.1.0/24"
  az          = var.instance_az
  subnet_name = "main-public-subnet"
}

# EC2 Module
module "ec2" {
  source        = "./modules/ec2"
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
}
