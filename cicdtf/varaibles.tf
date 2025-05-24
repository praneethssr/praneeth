variable "ssh_public_key" {
  description = "The SSH public key content for the EC2 key pair."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC45kHYSw8UDj9kBGrmkOiphdsz+9ImP1VN0p3UOi17C admin@praneeth"
}
