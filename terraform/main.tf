terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "thales eduardo"
      managed-by = "terraform"
    }
  }
}



