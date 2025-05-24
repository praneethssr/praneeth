# Content for cicdtf/modules/web/variables.tf

variable "ami_id" {
  description = "The ID of the AMI to use for the web instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch for the web server."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy the web instance into."
  type        = string
}

variable "key_name" {
  description = "The name of the EC2 Key Pair to use for SSH access."
  type        = string
}

variable "instance_name" {
  description = "A name tag for the web EC2 instance."
  type        = string
}
