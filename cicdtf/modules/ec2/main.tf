data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Conditionally create key pair only if public_key is provided
resource "aws_key_pair" "deployer_key" {
  count       = var.public_key != "" ? 1 : 0
  key_name    = "my-deployer-key"
  public_key  = var.public_key
}

resource "aws_instance" "this" {
  ami                    = var.ami != "" ? var.ami : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.public_key != "" ? aws_key_pair.deployer_key[0].key_name : var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.instance_name
  }
}
