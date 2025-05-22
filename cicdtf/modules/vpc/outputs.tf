# modules/vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the main public subnet"
  value       = aws_subnet.main.id # <--- CHANGED FROM aws_subnet.public.id
}

# Add other outputs if your VPC module has them, e.g., for private subnets, security group IDs, etc.