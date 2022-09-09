locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

resource "random_string" "identifier" {
  length  = 5
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.thumbprint]
  tags            = merge(local.tags, var.tags)
}

resource "aws_iam_role" "this" {
  name                 = "github-${random_string.identifier.result}"
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}