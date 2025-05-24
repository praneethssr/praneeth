# This file is located in the 'cicdtf/modules/web/' directory.

output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.server.id # CORRECTED: Changed 'this' to 'server'
}

output "public_ip" {
  description = "The public IP address of the created EC2 instance."
  value       = aws_instance.server.public_ip # CORRECTED: Changed 'this' to 'server'
}
