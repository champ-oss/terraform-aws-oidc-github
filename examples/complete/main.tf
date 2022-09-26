provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-oidc"
}

# deploy all resources
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

# deploy oidc provider only
module "oidc_only" {
  source            = "../../"
  git               = local.git
  url               = "https://token.actions.githubusercontenttestoidconly.com"
  name              = "oidc-github-oidc"
  enable_admin_role = false
  enable_read_role  = false
}

# create read only roles for following repos
module "read_only" {
  for_each = toset([
    "terraform-aws-repo1",
    "terraform-aws-repo2",
  ])
  source               = "../../"
  git                  = local.git
  name                 = each.value
  enable_oidc_provider = false
  enable_admin_role    = false
  trusted_read_repos   = concat(formatlist("repo:champtitles/%s:*", each.value), formatlist("repo:champtitles/%s:pull_request", each.value))
  oidc_provider_arn    = module.oidc_only.oidc_provider_arn
  depends_on           = [module.oidc_only]
}

# create admin only roles for following repos
module "admin_only" {
  for_each = toset([
    "terraform-aws-repo1",
    "terraform-aws-repo2",
  ])
  source               = "../../"
  git                  = local.git
  name                 = each.value
  enable_oidc_provider = false
  enable_read_role     = false
  trusted_admin_repos  = formatlist("repo:champtitles/%s:ref:refs/heads/main", each.value)
  oidc_provider_arn    = module.oidc_only.oidc_provider_arn
  depends_on           = [module.oidc_only]
}
