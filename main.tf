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
  url             = var.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.thumbprint]
  tags            = merge(local.tags, var.tags)
}

resource "aws_iam_role" "admin" {
  name                 = "${var.git}-admin"
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.admin.name
}

resource "aws_iam_role" "read" {
  name                 = "${var.git}-read"
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "read" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.read.name
}
