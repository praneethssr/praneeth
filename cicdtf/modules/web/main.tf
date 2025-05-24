# Corrected content of cicdtf/modules/web/main.tf

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

# Corrected module call for "some_nested_module"
# Assuming 'some_nested_module' is a sibling directory to 'web' in the 'modules' folder.
# The path '../../some_nested_module_actual_directory' means:
# 1. Go up one level from 'modules/web/' to 'modules/'
# 2. Go up another level from 'modules/' to the project root 'cicdtf/'
# 3. Go down into the 'modules/' directory
# 4. Go into the 'some_nested_module_actual_directory' (replace with the actual name)
module "some_nested_module" {
  source = "../../some_nested_module_actual_directory" # <--- FIX THIS PATH
  
  # Add any required inputs for 'some_nested_module' here
  # For example:
  # input_variable_name = "some_value"
}

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
