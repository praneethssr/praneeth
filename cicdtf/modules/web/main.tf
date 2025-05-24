# Content of cicdtf/modules/web/main.tf
resource "aws_instance" "web_server" {
  # ... your web server configuration ...
  # This is where the problematic module call might be!
  # For example:
  # module "nested_module" {
  #   source = "./modules/something" # <--- THIS IS THE KIND OF LINE CAUSING YOUR ERROR
  # }
}