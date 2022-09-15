locals {
  read_repos = var.trusted_repos != "" ? var.trusted_repos : var.trusted_read_repos
  admin_repos = var.trusted_repos != "" ? var.trusted_repos : var.trusted_admin_repos
}

data "aws_iam_policy_document" "read" {
  statement {
    principals {
      identifiers = [aws_iam_openid_connect_provider.this.arn]
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
      values   = var.trusted_repos != "" ? local.read_repos : null
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

data "aws_iam_policy_document" "admin" {
  statement {
    principals {
      identifiers = [aws_iam_openid_connect_provider.this.arn]
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
      values   = var.trusted_repos != "" ? local.admin_repos : null
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}
