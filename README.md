# terraform-module-template

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_policy"></a> [custom\_policy](#input\_custom\_policy) | point to data.aws\_iam\_policy\_document.custom.json | `any` | `null` | no |
| <a name="input_enable_admin_role"></a> [enable\_admin\_role](#input\_enable\_admin\_role) | enable admin role | `bool` | `true` | no |
| <a name="input_enable_oidc_provider"></a> [enable\_oidc\_provider](#input\_enable\_oidc\_provider) | enable/disable the creation of the github oidc provider | `bool` | `true` | no |
| <a name="input_enable_read_role"></a> [enable\_read\_role](#input\_enable\_read\_role) | enable read role | `bool` | `true` | no |
| <a name="input_git"></a> [git](#input\_git) | Name of the Git repo | `string` | n/a | yes |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role#max_session_duration | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | resource name | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | github openid arn | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_thumbprint"></a> [thumbprint](#input\_thumbprint) | You can retrieve this value from the IAM console | `string` | `"6938fd4d98bab03faadb97b34396831e3780aea1"` | no |
| <a name="input_trusted_admin_repos"></a> [trusted\_admin\_repos](#input\_trusted\_admin\_repos) | trusted repos to append to admin rules | `list(string)` | `null` | no |
| <a name="input_trusted_read_repos"></a> [trusted\_read\_repos](#input\_trusted\_read\_repos) | trusted repos to append rule for read only rules | `list(string)` | `null` | no |
| <a name="input_trusted_repos"></a> [trusted\_repos](#input\_trusted\_repos) | trusted repos to append rule | `list(string)` | `null` | no |
| <a name="input_url"></a> [url](#input\_url) | Name of the oidc url | `string` | `"https://token.actions.githubusercontent.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_iam_role_arn"></a> [custom\_iam\_role\_arn](#output\_custom\_iam\_role\_arn) | custom iam role |
| <a name="output_custom_iam_role_name"></a> [custom\_iam\_role\_name](#output\_custom\_iam\_role\_name) | custom iam name |
| <a name="output_iam_role_admin_arn"></a> [iam\_role\_admin\_arn](#output\_iam\_role\_admin\_arn) | IAM roles created mapping for github |
| <a name="output_iam_role_read_arn"></a> [iam\_role\_read\_arn](#output\_iam\_role\_read\_arn) | IAM roles created mapping for github |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | github oidc provider |
<!-- END_TF_DOCS -->