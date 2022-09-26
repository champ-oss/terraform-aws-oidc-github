locals {
  read_repos                      = var.trusted_read_repos != null ? var.trusted_read_repos : null
  admin_repos                     = var.trusted_admin_repos != null ? var.trusted_admin_repos : null
  aws_iam_openid_connect_provider = var.enable_oidc_provider ? aws_iam_openid_connect_provider.this[0].arn : ""
}

data "aws_iam_policy_document" "read" {
  count = var.enable_read_role ? 1 : 0
  statement {
    principals {
      identifiers = var.enable_oidc_provider != false ? [var.oidc_provider_arn] : [local.aws_iam_openid_connect_provider]
      type        = "Federated"
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      values   = var.trusted_repos != null ? var.trusted_repos : local.read_repos
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

data "aws_iam_policy_document" "admin" {
  count = var.enable_admin_role ? 1 : 0
  statement {
    principals {
      identifiers = var.enable_oidc_provider != false ? [var.oidc_provider_arn] : [local.aws_iam_openid_connect_provider]
      type        = "Federated"
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      values   = var.trusted_repos != null ? var.trusted_repos : local.admin_repos
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}
