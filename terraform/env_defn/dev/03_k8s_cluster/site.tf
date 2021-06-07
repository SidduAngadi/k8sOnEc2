provider "aws" {
    region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket       = "my-state-bucket-for-terraform"
    key          = "dev/03_k8s_cluster/terraform.tfstate"
    region       = "eu-west-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket       = "my-state-bucket-for-terraform"
    key          = "dev/01_network/terraform.tfstate"
    region       = "eu-west-1"
  }
}
