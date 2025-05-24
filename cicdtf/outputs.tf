output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the created public subnet."
  value       = module.vpc.public_subnet_id
}

output "ec2_instance_id" {
  description = "The ID of the general purpose EC2 instance."
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "The public IP of the general purpose EC2 instance."
  value       = module.ec2.public_ip
}

output "web_instance_id" {
  description = "The ID of the web server EC2 instance."
  value       = module.web.web_instance_id
}

output "web_public_ip" {
  description = "The public IP of the web server EC2 instance."
  value       = module.web.web_public_ip
}
