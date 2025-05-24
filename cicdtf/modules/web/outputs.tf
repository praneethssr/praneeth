# cicdtf/modules/web/outputs.tf - CORRECTED to remove duplicate outputs

output "web_instance_id" {
  description = "The ID of the web server EC2 instance."
  value       = aws_instance.web_instance.id
}

output "web_public_ip" {
  description = "The public IP address of the web server EC2 instance."
  value       = aws_instance.web_instance.public_ip
}
