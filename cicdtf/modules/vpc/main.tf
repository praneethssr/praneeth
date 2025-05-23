# --------------------------
# VPC Resource
# --------------------------
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# --------------------------
# Internet Gateway Resource
# --------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# --------------------------
# Public Subnet Resource
# --------------------------
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
  map_public_ip_on_launch = true # Automatically assign public IPs

  tags = {
    Name = var.subnet_name
  }
}

# --------------------------
# Route Table for Public Subnet
# --------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Allow all outbound traffic
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# --------------------------
# Route Table Association
# --------------------------
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

<<<<<<< HEAD
# --------------------------
# VPC Outputs
# --------------------------
# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.main.id
# }

# output "public_subnet_id" {
#   description = "The ID of the public subnet"
#   value       = aws_subnet.public.id
# }
=======
>>>>>>> d2309e1256bce4d47c67cb4f0c3b3561f22e957a
