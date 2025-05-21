terraform {
  backend "s3" {
    bucket         = "terraform-state-ssr123-ap-south-1"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "db-state-lock"
    encrypt        = true
  }
}
