# Resource: Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name_prefix = "${var.instance_name}-sg-"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
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

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

# Resource: EC2 Key Pair (Only if you want to manage it in this module)
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = var.public_key
}

# Resource: EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.instance_name
  }
}
