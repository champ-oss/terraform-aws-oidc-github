provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-oidc"
}

module "this" {
  source = "../../"
  trusted_repos = {
    values : ["repo:my-org/my-repo:pull_request","org/repo"]
  }
}