data "aws_iam_policy_document" "this" {
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
    dynamic "condition" {
      content {
        test     = "StringLike"
        variable = "token.actions.githubusercontent.com:sub"
        values   = var.trusted_repos
      }
    }
  }
}
