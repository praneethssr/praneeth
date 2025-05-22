variable "ami" {
  type    = string
  default = ""
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
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
