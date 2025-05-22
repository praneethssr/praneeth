variable "ami" {
  type    = string
  default = ""
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
  description = "Name of the EC2 key pair to use"
}


variable "instance_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
