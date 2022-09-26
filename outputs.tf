output "iam_role_admin_arn" {
  description = "IAM roles created mapping for github"
  value       = var.enable_admin_role != false ? aws_iam_role.admin[0].arn : null
}

output "iam_role_read_arn" {
  description = "IAM roles created mapping for github"
  value       = var.enable_read_role != false ? aws_iam_role.read[0].arn : null
}

output "custom_iam_role_arn" {
  description = "custom iam role"
  value       = var.custom_policy != null ? aws_iam_role.custom[0].arn : null
}

output "custom_iam_role_name" {
  description = "custom iam name"
  value       = var.custom_policy != null ? aws_iam_role.custom[0].name : null
}

output "openid_arn" {
  description = "github openid arn"
  value       = var.enable_oidc_provider != false ? aws_iam_openid_connect_provider.this[0].arn : null
}