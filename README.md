[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-dynamodb/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-dynamodb.svg)](https://github.com/boldlink/terraform-aws-dynamodb/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS DynamoDB Terraform Module

This Terraform module provides an efficient and secure method to create an AWS DynamoDB table along with its item(s), encapsulating best practices and simplifying the deployment of scalable, serverless NoSQL databases.

## 🚀 Features

- **Effortless Deployment**: Streamline the creation of DynamoDB tables with predefined configurations and optional item population.
- **Built-in Encryption**: Support for encryption at rest using AWS Key Management Service (KMS) to protect your data.
- **Security Compliance**: Adherence to AWS security best practices, scanned for vulnerabilities using Checkov.

## 🌟 Why Use This Module

### Simplified Experience

- **Abstraction of Complexity**: Seamlessly orchestrate the creation of DynamoDB tables and items without delving into the intricacies of individual Terraform resources.

### Comprehensive Documentation

- **Elaborate Examples**: Provides detailed examples that guide you through different use-cases, ensuring ease of use and a smooth learning curve.

### Security and Compliance

- **Encryption Support**: Ensures your data is secure by:
  - Enabling encryption at rest using AWS KMS.
  - Automatically creating a KMS key if encryption is specified and a custom key isn’t provided.

- **Adherence to Security Best Practices**: This module:
  - Follows AWS's best practices for secure and compliant infrastructure as code.
  - Utilizes [Checkov](https://www.checkov.io/) to scan and mitigate potential vulnerabilities, ensuring your DynamoDB deployment is secure and compliant.

## 🚀 Quick Start

[Insert Quick Start Guide or Basic Usage Example Here]

## 📘 Usage & Examples

Navigate to [examples](./examples) for detailed usage scenarios and module configurations.

### **Important Points to Note**:
- These examples use the latest version of this module
- Global Secondary Index can be created or deleted for a previously created table. This can take more time if the table is populated.
- Currently, there is no support for `ignore_changes` for both `write_capacity` and `read_capacity` in `global_secondary_index`.  
An issue about this has been raised [here](https://github.com/hashicorp/terraform-provider-aws/issues/17096) hence it could be solved possibly when `global_secondary_index` will be a separate resource.
- For Autoscaled indices (module `autoscaling_indexes`) it is important to have both `read_min_capacity` and `write_min_capacity` values match the values provided for `write_capacity` and `read_capacity` in the `global_secondary_index`. This will prevent terraform from trying to change the values when you do a `terraform plan/terraform apply`. See below;

```hcl
module "abc" {
  ......(other configuration here)

  autoscaling_indexes = {
    IndexName = {
      ......(other configuration here)

      read_min_capacity  = 10
      write_min_capacity = 10
    }
  }

  global_secondary_index = [
    {
      ......(other configuration here)

      write_capacity     = 10
      read_capacity      = 10
    }
  ]
}
```

## Usage

```hcl
module "dynamodb_table" {
  source         = "boldlink/dynamodb/aws"
  version        = "<provide_latest_version_here>
  name           = "minimum-example"
  read_capacity  = 3
  write_capacity = 4
  hash_key       = "UserId"

  attributes = [
    {
      name = "UserId"
      type = "S"
    }
  ]

  tags = {
    Name        = "minimum-example"
    Environment = "dev"
  }
}
```
## Documentation

[Amazon DynamoDB Documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.dynamodb_table_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.index_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.index_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.table_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.dynamodb_table_read_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.dynamodb_table_write_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.index_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.index_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table_item.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |
| [aws_kms_alias.ddbsse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ddbsse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sse_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_alias.aws_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_kms_permissions"></a> [additional\_kms\_permissions](#input\_additional\_kms\_permissions) | Add additional policies for the DDB SSE Key created by this module | `any` | `[]` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | (Required) List of nested attribute definitions. Only required for hash\_key and range\_key attributes. | `list(map(string))` | `[]` | no |
| <a name="input_autoscaling_defaults"></a> [autoscaling\_defaults](#input\_autoscaling\_defaults) | A map of default autoscaling settings. | `map(string)` | <pre>{<br>  "scale_in_cooldown": 0,<br>  "scale_out_cooldown": 0,<br>  "target_value": 50<br>}</pre> | no |
| <a name="input_autoscaling_indexes"></a> [autoscaling\_indexes](#input\_autoscaling\_indexes) | A map of index autoscaling configurations. See example in examples/autoscaling | `map(map(string))` | `{}` | no |
| <a name="input_autoscaling_read"></a> [autoscaling\_read](#input\_autoscaling\_read) | A map of read autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling | `map(string)` | `{}` | no |
| <a name="input_autoscaling_write"></a> [autoscaling\_write](#input\_autoscaling\_write) | A map of write autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling | `map(string)` | `{}` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | (Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PROVISIONED` | `string` | `"PROVISIONED"` | no |
| <a name="input_create_sse_kms_key"></a> [create\_sse\_kms\_key](#input\_create\_sse\_kms\_key) | Specify whether you want to create the sse\_kms\_key using this module. | `bool` | `false` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Determines whether to enable autoscaling for the DynamoDB table. | `bool` | `false` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specify whether to enable kms key rotation. | `bool` | `true` | no |
| <a name="input_global_secondary_index"></a> [global\_secondary\_index](#input\_global\_secondary\_index) | Additional global secondary indexes in the form of a list of mapped values. These mapped values are: `hash_key`, `name`, `non_key_attributes`, `projection_type`, `range_key`, `read_capacity` and `write_capacity`. **Note**: For `PAY_PER_REQUEST (On-demand)` mode both `read_capacity` and `write_capacity` are `not applicable`. | `list(any)` | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | (Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an `attribute` | `string` | n/a | yes |
| <a name="input_key_deletion_window"></a> [key\_deletion\_window](#input\_key\_deletion\_window) | The waiting period, specified in number of days. Must be between `7` and `30`inclusive. | `number` | `7` | no |
| <a name="input_local_secondary_index"></a> [local\_secondary\_index](#input\_local\_secondary\_index) | (Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the table, this needs to be unique within a region. | `string` | n/a | yes |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | Specify whether to enable point-in-time-recovery for the dynamodb table. | `bool` | `true` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | (Optional, Forces new resource) The attribute to use as the range (sort) key. Must also be defined as an `attribute` | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | (Optional) The number of read units for this table. If the billing\_mode is `PROVISIONED`, this field is `required`. | `number` | `null` | no |
| <a name="input_replica"></a> [replica](#input\_replica) | (Optional) Configuration block(s) with [DynamoDB Global Tables V2 (version 2019.11.21)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.V2.html) replication configurations. | `map(string)` | `{}` | no |
| <a name="input_restore_date_time"></a> [restore\_date\_time](#input\_restore\_date\_time) | (Optional) The time of the point-in-time recovery point to restore. | `string` | `null` | no |
| <a name="input_restore_source_name"></a> [restore\_source\_name](#input\_restore\_source\_name) | (Optional) The name of the table to restore. Must match the name of an existing table. | `string` | `null` | no |
| <a name="input_restore_to_latest_time"></a> [restore\_to\_latest\_time](#input\_restore\_to\_latest\_time) | (Optional) If set, restores table to the most recent point-in-time recovery point. | `bool` | `false` | no |
| <a name="input_sse_enabled"></a> [sse\_enabled](#input\_sse\_enabled) | Specify whether server-side encryption is enabled for the dynamodb table. If enabled is `false` then server-side encryption is set to AWS owned CMK (shown as `DEFAULT` in the AWS console). If enabled is `true` and no `kms_key_arn` is specified then server-side encryption is set to AWS managed CMK (shown as `KMS` in the AWS console). | `bool` | `false` | no |
| <a name="input_sse_kms_key_arn"></a> [sse\_kms\_key\_arn](#input\_sse\_kms\_key\_arn) | Provide the ARN for the KMS key to use for DDB server-side encryption. | `string` | `null` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | (Optional) Indicates whether Streams are to be enabled (true) or disabled (false). | `bool` | `false` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | (Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are `KEYS_ONLY`, `NEW_IMAGE`, `OLD_IMAGE`, `NEW_AND_OLD_IMAGES`. | `string` | `null` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | (Optional) The storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`. | `string` | `"STANDARD"` | no |
| <a name="input_table_items"></a> [table\_items](#input\_table\_items) | Block for adding table item(s). | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to populate on the created table. If configured with a provider [default\_tags configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Specify timeouts for creating, updating and deleting tables | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | (Optional) Defines ttl, has two properties, and can only be specified once | `map(string)` | `{}` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | (Optional) The number of write units for this table. If the billing\_mode is `PROVISIONED`, this field is `required`. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The arn of the table |
| <a name="output_hash_key"></a> [hash\_key](#output\_hash\_key) | The hash key of the table |
| <a name="output_id"></a> [id](#output\_id) | The name of the table |
| <a name="output_stream_arn"></a> [stream\_arn](#output\_stream\_arn) | The ARN of the Table Stream. Only available when `stream_enabled = true` |
| <a name="output_stream_label"></a> [stream\_label](#output\_stream\_label) | A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when `stream_enabled = true` |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```

#### BOLDLink-SIG 2023
