<<<<<<< HEAD
# Corrected content for cicdtf/modules/web/outputs.tf

# Output for the web instance ID
output "web_instance_id" {
  description = "The ID of the web server EC2 instance."
  value       = aws_instance.web_instance.id
}

# Output for the public IP of the web instance (if applicable)
output "web_public_ip" {
  description = "The public IP address of the web server EC2 instance."
  value       = aws_instance.web_instance.public_ip
}

# IMPORTANT: Any 'variable' declarations (like 'variable "instance_type"')
# that were previously in this file have been removed.
# Variables should only be declared in 'modules/web/variables.tf'.
=======
# cicdtf/modules/web/outputs.tf

output "web_instance_id" {
  description = "The ID of the web server EC2 instance."
  value       = aws_instance.web_instance.id
}

output "web_public_ip" {
  description = "The public IP address of the web server EC2 instance."
  value       = aws_instance.web_instance.public_ip
}
>>>>>>> 1c3a492 (Update EC2, VPC, and Web modules with changes to main, outputs, and variables)
