<<<<<<< HEAD
=======
# modules/ec2/outputs.tf

>>>>>>> f458e3199351657429f857c20a630cada0c938e7
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.web.private_ip
<<<<<<< HEAD
}
=======
}

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.web.id
}
>>>>>>> f458e3199351657429f857c20a630cada0c938e7
