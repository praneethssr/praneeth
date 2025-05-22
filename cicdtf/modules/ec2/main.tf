resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name
  public_key = var.ssh_public_key
}
