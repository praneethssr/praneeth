# Content of cicdtf/modules/web/variables.tf
variable "instance_type" {
  description = "Type of EC2 instance for web server"
  type        = string
  default     = "t2.micro"
}
# ... other variables ...