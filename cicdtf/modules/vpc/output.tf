# This file is located in the 'cicdtf/modules/vpc/' directory.

output "pb_sn" {
  value       = aws_subnet.pb_sn.id
  description = "The ID of the public subnet"
}

output "sg" {
  value       = aws_security_group.sg.id
  description = "The ID of the security group"
}

# New output for VPC ID (useful if you expand your architecture)
output "vpc_id" {
  value = aws_vpc.myvpc.id
  description = "The ID of the VPC"
}
