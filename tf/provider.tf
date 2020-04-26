# Configure AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}