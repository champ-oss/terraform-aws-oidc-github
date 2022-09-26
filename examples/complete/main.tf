provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-oidc"
}

# deploy all resources at once
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
module "oidc_with_many_roles" {
  for_each = toset([
    "terraform-aws-repo1",
    "terraform-aws-repo2",
  ])
  source            = "../../"
  git               = local.git
  url               = "https://token.actions.githubusercontenttestoidconly.com"
  name              = each.value
  trusted_read_repos   = concat(formatlist("repo:champtitles/%s:*", each.value), formatlist("repo:champtitles/%s:pull_request", each.value))
  trusted_admin_repos  = formatlist("repo:champtitles/%s:ref:refs/heads/main", each.value)
}
