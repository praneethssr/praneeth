<<<<<<< HEAD
# modules/ec2/main.tf (or modules/ec2/outputs.tf if you have a separate file)

# ... (rest of your aws_instance.web resource configuration above) ...

# --------------------------
# EC2 Outputs
# --------------------------
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.web.public_ip  # <<< CORRECTED: Reference aws_instance.web
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.web.private_ip # <<< CORRECTED: Reference aws_instance.web
=======
# --------------------------
# Security Group for EC2
# --------------------------
resource "aws_security_group" "instance_sg" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

# --------------------------
# EC2 Instance Resource
# --------------------------
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = var.instance_name
  }
>>>>>>> d2309e1256bce4d47c67cb4f0c3b3561f22e957a
}

# (If you had an "instance_id" output, correct it similarly)
output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.web.id       # <<< CORRECTED: Reference aws_instance.web
}