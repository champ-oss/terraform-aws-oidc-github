locals {
  read_repos  = var.trusted_read_repos != null ? var.trusted_read_repos : null
  admin_repos = var.trusted_admin_repos != null ? var.trusted_admin_repos : null
}

data "aws_iam_policy_document" "read" {
  statement {
    principals {
      identifiers = var.enable_read_role != true ? [var.openid_arn] : [aws_iam_openid_connect_provider.this[0].arn]
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
      identifiers = var.enable_admin_role != true ? [var.openid_arn] : [aws_iam_openid_connect_provider.this[0].arn]
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
