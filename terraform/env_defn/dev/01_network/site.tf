provider "aws" {
    region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket       = "my-state-bucket-for-terraform"
    key          = "dev/01_network/terraform.tfstate"
    region       = "eu-west-1"
  }
}
