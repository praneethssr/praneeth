terraform {
  backend "s3" {
    bucket         = "terraform-state-ssr123-ap-south-1" # Your specified S3 bucket name
    key            = "terraform.tfstate"                 # Path to the state file within the bucket
    region         = "ap-south-1"                        # Your specified region
    dynamodb_table = "DB_Terraform_State_Bucket"         # Your specified DynamoDB table for state locking
    encrypt        = true                                # Enable encryption for the state file in S3
  }
}
