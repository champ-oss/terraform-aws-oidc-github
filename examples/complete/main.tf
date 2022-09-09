provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-oidc"
}

module "this" {
  source = "../../"
  git    = local.git
  trusted_repos = [
    "repo:my-org/my-repo:pull_request",
    "org/repo"
  ]
}