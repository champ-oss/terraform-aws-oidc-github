variable "thumbprint" {
  description = "You can retrieve this value from the IAM console"
  default     = "6938fd4d98bab03faadb97b34396831e3780aea1"
  type        = string
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
}

variable "url" {
  description = "Name of the oidc url"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "trusted_repos" {
  description = "trusted repos to append rule"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "max_session_duration" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role#max_session_duration"
  type        = number
  default     = 3600
}

variable "enable_admin_role" {
  description = "enable admin role"
  type        = bool
  default     = true
}

variable "enable_read_role" {
  description = "enable read role"
  type        = bool
  default     = true
}

variable "enable_custom_role" {
  description = "enable custom role"
  type        = bool
  default     = false
}

variable "custom_policy_arns" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role#managed_policy_arns"
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  type        = list(string)
}

