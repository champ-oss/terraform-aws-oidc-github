locals {
  read_repos                      = var.trusted_read_repos != null ? var.trusted_read_repos : null
  admin_repos                     = var.trusted_admin_repos != null ? var.trusted_admin_repos : null
  aws_iam_openid_connect_provider = var.enable_oidc_provider != false ? aws_iam_openid_connect_provider.this[0].arn : null
}

data "aws_iam_policy_document" "read" {
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
