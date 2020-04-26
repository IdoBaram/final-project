resource "tls_private_key" "final_project_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "final_project_key" {
  key_name   = "final_project_key"
  public_key = tls_private_key.final_project_key.public_key_openssh
}

resource "local_file" "final_project_key" {
  sensitive_content  = tls_private_key.final_project_key.private_key_pem
  filename           = "final_project_key.pem"
}