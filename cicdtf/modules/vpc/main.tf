# This file is located in the 'cicdtf/modules/vpc/' directory.

resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr_block # Using variable
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name # Using variable
  }
}

resource "aws_subnet" "pb_sn" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_cidr # Using variable
  availability_zone       = var.availability_zone # Using variable
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet" # Consistent naming
  }
}

resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "${var.vpc_name}-sg" # Consistent naming
  description = "Security Group for ${var.vpc_name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
