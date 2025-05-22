# modules/vpc/outputs.tf

# Output: VPC ID
# Exports the ID of the created VPC.
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

# Output: Public Subnet ID
# Exports the ID of the created public subnet.
output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.public.id
}
