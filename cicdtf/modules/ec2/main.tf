# modules/ec2/main.tf (or modules/ec2/outputs.tf if you have a separate file)

# ... (rest of your aws_instance.web resource configuration above) ...

# --------------------------
# EC2 Outputs
# --------------------------
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.web.public_ip  # <<< CORRECTED: Reference aws_instance.web
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.web.private_ip # <<< CORRECTED: Reference aws_instance.web
}

# (If you had an "instance_id" output, correct it similarly)
output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.web.id       # <<< CORRECTED: Reference aws_instance.web
}