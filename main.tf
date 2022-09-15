locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = var.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.thumbprint]
  tags            = merge(local.tags, var.tags)
}

resource "aws_iam_role" "admin" {
  count                = var.enable_admin_role ? 1 : 0
  name                 = "${var.git}-admin"
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "admin" {
  count      = var.enable_admin_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.admin.name
}

resource "aws_iam_role" "read" {
  count                = var.enable_read_role ? 1 : 0
  name                 = "${var.git}-read"
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "read" {
  count      = var.enable_read_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.read.name
}
