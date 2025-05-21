resource "aws_s3_bucket" "tf_state" {
  bucket        = "terraform-state-ssr123-ap-south-1"
  force_destroy = true

  tags = {
    Name        = "DB Terraform State Bucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name         = "db-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "DB State Lock Table"
    Environment = "Dev"
  }
}
