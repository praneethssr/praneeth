# provider "aws" {
#   region = var.aws_region # Retrieves the region from cicdtf/variables.tf
# }

# Backend configuration for Terraform state management.
# This tells Terraform to store its state in an S3 bucket for collaborative use and durability.
terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket-name" # <<== IMPORTANT: REPLACE WITH YOUR ACTUAL S3 BUCKET NAME
    key            = "cicdtf/terraform.tfstate"                 # Path to your state file within the bucket
    region         = "ap-south-1"                               # Must match your AWS_DEFAULT_REGION
    encrypt        = true                                       # Ensures state file is encrypted at rest
    # dynamodb_table = "your-terraform-locks-table"             # OPTIONAL: Uncomment and replace for state locking
  }
}

# Resource to create an EC2 Key Pair in AWS.
# The public key content is passed dynamically from your GitHub Actions workflow.
resource "aws_key_pair" "deployer_key" {
  key_name   = "my-deployer-key"        # The name of the key pair that will appear in AWS
  public_key = var.public_key           # This variable will be set by your GitHub Actions workflow
}

# Data source to find the latest Amazon Linux 2 AMI.
# This ensures your EC2 instance always uses a current and patched operating system image.
data "aws_ami" "amazon_linux_2" {
  most_recent = true     # Get the most recently published AMI
  owners      = ["amazon"] # Filter for AMIs owned by Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Pattern for Amazon Linux 2 (HVM, x86_64, GP2 root volume)
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Module call for VPC creation.
# This delegates the creation of your Virtual Private Cloud infrastructure to a dedicated module.
module "vpc" {
  source      = "./modules/vpc"         # Path to your VPC module
  cidr_block  = "10.0.0.0/16"           # CIDR block for the entire VPC
  vpc_name    = "my-app-vpc"            # Name tag for the VPC
  subnet_cidr = "10.0.1.0/24"           # CIDR block for the main public subnet
  az          = var.instance_az         # Availability Zone for the public subnet (e.g., ap-south-1a)
  subnet_name = "main-public-subnet"    # Name tag for the public subnet
}

# Module call for EC2 instance creation.
# This delegates the creation of your EC2 instance to a dedicated module.
module "ec2" {
  source        = "./modules/ec2"                   # Path to your EC2 module
  ami           = data.aws_ami.amazon_linux_2.id    # AMI ID retrieved from the data source
  instance_type = "t2.micro"                        # Instance type for the EC2 instance
  key_name      = aws_key_pair.deployer_key.key_name # Name of the EC2 Key Pair
  instance_name = "MyEC2Instance"                   # Name tag for the EC2 instance
  vpc_id        = module.vpc.vpc_id                 # VPC ID from the VPC module output
  subnet_id     = module.vpc.public_subnet_id       # Public Subnet ID from the VPC module output
}
