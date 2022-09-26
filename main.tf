locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

resource "aws_iam_openid_connect_provider" "this" {
  count           = var.enable_oidc_provider ? 1 : 0
  url             = var.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.thumbprint]
  tags            = merge(local.tags, var.tags)
}

resource "aws_iam_role" "admin" {
  count                = var.enable_admin_role ? 1 : 0
  name                 = "${var.name}-admin"
  assume_role_policy   = data.aws_iam_policy_document.admin.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "admin" {
  count      = var.enable_admin_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.admin[0].name
}

resource "aws_iam_role" "read" {
  count                = var.enable_read_role ? 1 : 0
  name                 = "${var.name}-read"
  assume_role_policy   = data.aws_iam_policy_document.read.json
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "read" {
  count      = var.enable_read_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.read[0].name
}

resource "aws_iam_role" "custom" {
  count                = var.custom_policy != null ? 1 : 0
  name                 = "${var.name}-custom"
  assume_role_policy   = var.custom_policy
  max_session_duration = var.max_session_duration
  tags                 = merge(local.tags, var.tags)
}
