terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.9.0"
    }
  }
}

provider "aws" {
  region = var.region

  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  token = var.AWS_SESSION_TOKEN

  default_tags {
    tags = {
      Owner       = var.owner
      Purpose     = "TFE-SNOW-Demo"
      Terraform   = true
      Environment = "development"
      DoNotDelete = true
    }
  }
}
