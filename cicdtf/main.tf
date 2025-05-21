module "vpc" {
  source = "./modules/vpc"
}



resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = ""
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
}
# cicdtf/main.tf (Corrected)

resource "aws_key_pair" "deployer_key" {
  public_key = var.public_key # <--- Use the variable here
  key_name   = "deployer-key" # Ensure you have a key_name defined, e.g., "deployer-key"
  # ... other attributes
}
