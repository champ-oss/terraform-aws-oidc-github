variable "thumbprint" {
  description = "You can retrieve this value from the IAM console"
  default     = "6938fd4d98bab03faadb97b34396831e3780aea1"
  type        = string
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
}

variable "trusted_repos" {
  description = "trusted repos to append rule"
  type        = list(any)
  default     = []
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

