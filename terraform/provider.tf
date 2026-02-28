terraform {
  backend "s3" {
    bucket         = "cloud-native-sre-platform-tfstate-14101999"
    key            = "global/sre-platform/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}