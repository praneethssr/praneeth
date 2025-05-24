<<<<<<< HEAD
# FINAL Corrected content of cicdtf/modules/web/main.tf
=======
# cicdtf/modules/web/main.tf
>>>>>>> 1c3a492 (Update EC2, VPC, and Web modules with changes to main, outputs, and variables)

resource "aws_instance" "web_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  tags = {
    Name = "${var.instance_name}-web"
  }
}
<<<<<<< HEAD
=======

# No 'some_nested_module' in this file.

>>>>>>> 1c3a492 (Update EC2, VPC, and Web modules with changes to main, outputs, and variables)
