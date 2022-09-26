provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-oidc"
}

module "this" {
  source = "../../"
  git    = local.git
  name   = local.git
  url    = "https://token.actions.githubusercontenttest.com"
  trusted_admin_repos = [
    "org/repo"
  ]
  trusted_read_repos = [
    "repo:my-org/my-repo:pull_request"
  ]
}

module "oidc_only" {
  source              = "../../"
  git                 = local.git
  url                 = "https://token.actions.githubusercontenttestoidconly.com"
  name                = "oidc-github-oidc"
  enable_admin_role   = false
  enable_read_role    = false
}

module "read_only" {
  source               = "../../"
  git                  = local.git
  name                 = "oidc-github-readtest"
  enable_oidc_provider = false
  enable_admin_role    = false
  trusted_read_repos = [
    "repo:my-org/my-repo:pull_request"
  ]
  oidc_provider_arn   = module.oidc_only.oidc_provider_arn
  depends_on          = [module.oidc_only]
}

module "admin_only" {
  source               = "../../"
  git                  = local.git
  name                 = "oidc-github-admintest"
  enable_oidc_provider = false
  enable_read_role     = false
  trusted_admin_repos = [
    "org/repo"
  ]
  oidc_provider_arn  = module.oidc_only.oidc_provider_arn
  depends_on         = [module.oidc_only]
}
