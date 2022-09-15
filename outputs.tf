output "iam_role_admin_arn" {
  description = "IAM roles created mapping for github"
  value       = aws_iam_role.admin[0].arn
}

output "iam_role_read_arn" {
  description = "IAM roles created mapping for github"
  value       = aws_iam_role.read[0].arn
}