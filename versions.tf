terraform {
  required_version = ">= 0.15.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.17.1"
    }
  }
}
