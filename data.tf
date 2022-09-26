locals {
  read_repos                      = var.trusted_read_repos != null ? var.trusted_read_repos : null
  admin_repos                     = var.trusted_admin_repos != null ? var.trusted_admin_repos : null
  aws_iam_openid_connect_provider = var.enable_oidc_provider ? aws_iam_openid_connect_provider.this[0].arn : data.aws_iam_openid_connect_provider.this[0].arn
}

data "aws_iam_openid_connect_provider" "this" {
  count = var.enable_oidc_provider ? 1 : 0
  url   = data.tls_certificate.this.url
}

data "tls_certificate" "this" {
  url = var.url
}

data "aws_iam_policy_document" "read" {
  statement {
    principals {
      identifiers = [local.aws_iam_openid_connect_provider]
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
      identifiers = [local.aws_iam_openid_connect_provider]
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
