terraform {
  backend "s3" {
    bucket  = "terraform-state-ssr123-ap-south-1"
    key     = "cicdtf/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # dynamodb_table = "your-terraform-locks-table"
  }
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key
}

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

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  vpc_name    = "my-app-vpc"
  subnet_cidr = "10.0.1.0/24"
  az          = var.instance_az
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
