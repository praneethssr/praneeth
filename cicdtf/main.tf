# Your root main.tf (e.g., cicdtf/main.tf)

# ... (other code in your root main.tf) ...

# --------------------------
# EC2 Module
# --------------------------
module "ec2" {
  source         = "./modules/ec2" # Path to your EC2 module
  ami            = data.aws_ami.amazon_linux_2.id
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.deployer_key.key_name
  instance_name  = "MyEC2Instance" # <--- ADD/ENSURE THIS LINE EXISTS
  vpc_id         = module.vpc.vpc_id # <--- ADD/ENSURE THIS LINE EXISTS
  subnet_id      = module.vpc.public_subnet_id
}

# ... (other code in your root main.tf) ...
