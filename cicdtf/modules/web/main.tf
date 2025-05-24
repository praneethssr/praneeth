# This file is located in the 'cicdtf/modules/web/' directory.

resource "aws_instance" "server" {
  ami           = var.ami_id          # Now correctly references the declared variable
  instance_type = "t2.micro"

  subnet_id       = var.subnet_id     # Using variable
  security_groups = [var.sg]          # CORRECTED: Changed from [var.sg.id] to [var.sg]
  key_name        = var.key_name      # Using variable

  tags = {
    Name = var.instance_name         # Using variable
  }
}
