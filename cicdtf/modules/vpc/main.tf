# modules/vpc/main.tf

# Resource: AWS VPC
# Creates the main Virtual Private Cloud.
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# Resource: Internet Gateway
# Attaches an Internet Gateway to the VPC to allow communication with the internet.
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Resource: Public Subnet
# Creates a public subnet within the VPC.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true # Automatically assign public IP to instances in this subnet

  tags = {
    Name = var.subnet_name
  }
}

# Resource: Route Table for Public Subnet
# Creates a route table and a default route to the Internet Gateway.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Route all outbound traffic
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Resource: Route Table Association
# Associates the public subnet with the public route table.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
