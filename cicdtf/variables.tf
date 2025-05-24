variable "aws_region" {
  description = "AWS region for deployments."
  type        = string
  default     = "ap-south-1" # Match your GitHub Actions env.AWS_REGION
}

variable "public_key" {
  description = "Public key for SSH access to EC2 instances. Comes from TF_VAR_public_key secret."
  type        = string
  sensitive   = true
}