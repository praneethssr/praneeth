# FINAL Corrected content of cicdtf/modules/web/main.tf

# Example web server instance definition
resource "aws_instance" "web_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  tags = {
    Name = "${var.instance_name}-web"
  }
}

# The 'module "some_nested_module"' block HAS BEEN PERMANENTLY REMOVED from this file.
# If you actually need a nested module here, you must add it back with a CORRECT and EXISTING source path,
# e.g., source = "../../<your_actual_nested_module_name>"
# and ensure that module definition truly exists in your project.

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
