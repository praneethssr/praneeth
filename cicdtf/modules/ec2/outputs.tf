# modules/ec2/outputs.tf

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.web.private_ip
}

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.web.id
}
