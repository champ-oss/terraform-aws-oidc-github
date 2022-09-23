output "iam_role_admin_arn" {
  description = "IAM roles created mapping for github"
  value       = aws_iam_role.admin[0].arn
}

output "iam_role_read_arn" {
  description = "IAM roles created mapping for github"
  value       = aws_iam_role.read[0].arn
}

output "custom_iam_role_arn" {
  description = "custom iam role"
  value       = var.custom_policy != null ? aws_iam_role.custom[0].arn : null
}

output "custom_iam_role_name" {
  description = "custom iam name"
  value       = var.custom_policy != null ? aws_iam_role.custom[0].name : null
}