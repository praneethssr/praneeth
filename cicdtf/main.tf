# C:\Users\admin\cicdtf\cicdtf\main.tf

# 1. VPC Module (already there)
module "vpc" {
  source = "./modules/vpc"
  # ... other variables for your VPC module ...
  cidr_block  = "10.0.0.0/16" # Example
  vpc_name    = "my-app-vpc"  # Example
  subnet_cidr = "10.0.1.0/24" # Example
  az          = "ap-south-1a" # <--- IMPORTANT: Set this to a supported AZ
  subnet_name = "main-public-subnet" # Example
}

# 2. AWS Key Pair Resource (MUST be in the root module)
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"
  public_key = file("my-deployer-key.pub") # <--- Use the correct absolute path
}
# 3. AWS AMI Data Source (MUST be in the root module if referenced by the module)
# This will find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 4. EC2 Module (already there, but now referencing the correctly declared resources)
module "ec2" {
  source        = "./modules/ec2"
  ami           = data.aws_ami.amazon_linux_2.id # Reference the AMI ID from the data source
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name # Reference the key name from the resource
  instance_name = "MyEC2Instance"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
}
