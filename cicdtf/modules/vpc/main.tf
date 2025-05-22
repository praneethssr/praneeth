# modules/vpc/main.tf

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# This subnet is currently named "main" and uses var.az.
# If you intend this to be your *primary* public subnet, consider renaming it
# or ensuring var.az is set to a valid AZ (like "ap-south-1a" or "ap-south-1b").
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az # Make sure the input var.az is set to 'ap-south-1a' or 'ap-south-1b'
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_rt.id
}

# --- REMOVED THE DUPLICATE `resource "aws_subnet" "public"` blocks ---
# You had two blocks with resource "aws_subnet" "public".
# The one you meant to use for the EC2 instance should be the one you output.
# I will assume `aws_subnet.main` is the one you want to output.

# If you wanted a *second* public subnet, you would give it a unique local name:
/*
resource "aws_subnet" "secondary_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24" # A unique CIDR for the second subnet
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b" # Or "ap-south-1a" if the other one is "ap-south-1b"
  tags = {
    Name = "${var.vpc_name}-secondary-public-subnet"
  }
}
*/

# --- Outputs for the VPC Module ---
# modules/vpc/outputs.tf (assuming you have this file)
# Make sure your outputs provide the VPC ID and the public subnet ID
# that you intend to use for your EC2 instance.

# Example outputs.tf content:
/*
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the main public subnet"
  value       = aws_subnet.main.id # Or aws_subnet.secondary_public.id if you use that
}
*/