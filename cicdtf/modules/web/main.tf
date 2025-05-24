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
