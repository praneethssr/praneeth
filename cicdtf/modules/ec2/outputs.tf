# modules/ec2/outputs.tf

# Output: Instance ID
# Exports the ID of the created EC2 instance.
output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.ec2_instance.id
}

# Output: Instance Public IP
# Exports the public IP address of the EC2 instance.
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.ec2_instance.public_ip
}

# Output: Instance Private IP
# Exports the private IP address of the EC2 instance.
output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.ec2_instance.private_ip
}
