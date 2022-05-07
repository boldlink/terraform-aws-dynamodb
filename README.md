
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)

# AWS DynamoDB Terraform module

## Description

This terraform module creates a dynamodb table and items

Examples available [`here`](https://github.com/boldlink/terraform-aws-dynamodb/tree/main/examples)

## Documentation

[Amazon DynamoDB Documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.dynamodb_table_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.dynamodb_table_read_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.dynamodb_table_write_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table_item.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | (Required) List of nested attribute definitions. Only required for hash\_key and range\_key attributes. | `list(map(string))` | `[]` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | (Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PROVISIONED` | `string` | `"PROVISIONED"` | no |
| <a name="input_create_dynamodb_item"></a> [create\_dynamodb\_item](#input\_create\_dynamodb\_item) | Specify whether to create dynamodb item | `bool` | `false` | no |
<<<<<<< HEAD
| <a name="input_dynamodb_table_max_read_capacity"></a> [dynamodb\_table\_max\_read\_capacity](#input\_dynamodb\_table\_max\_read\_capacity) | The maximum number of read units for this table. | `number` | `100` | no |
| <a name="input_dynamodb_table_max_write_capacity"></a> [dynamodb\_table\_max\_write\_capacity](#input\_dynamodb\_table\_max\_write\_capacity) | The maximum number of write units for this table. | `number` | `100` | no |
| <a name="input_dynamodb_table_min_read_capacity"></a> [dynamodb\_table\_min\_read\_capacity](#input\_dynamodb\_table\_min\_read\_capacity) | The minimum number of read units for this table. | `number` | `5` | no |
| <a name="input_dynamodb_table_min_write_capacity"></a> [dynamodb\_table\_min\_write\_capacity](#input\_dynamodb\_table\_min\_write\_capacity) | The minimum number of write units for this table. | `number` | `5` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Determines whether to enable autoscaling for the DynamoDB table | `bool` | `false` | no |
| <a name="input_global_secondary_index"></a> [global\_secondary\_index](#input\_global\_secondary\_index) | Additional global secondary indexes in the form of a list of mapped values | <pre>list(object({<br>    hash_key           = string<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>    read_capacity      = number<br>    write_capacity     = number<br>  }))</pre> | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | (Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an `attribute` | `string` | n/a | yes |
| <a name="input_item_range_key"></a> [item\_range\_key](#input\_item\_range\_key) | (Optional) Range key to use for lookups and identification of the item. Required if there is range key defined in the table. | `string` | `null` | no |
| <a name="input_local_secondary_index"></a> [local\_secondary\_index](#input\_local\_secondary\_index) | (Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the table, this needs to be unique within a region. | `string` | n/a | yes |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | (Optional) Enable point-in-time recovery | `map(string)` | `{}` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | (Optional, Forces new resource) The attribute to use as the range (sort) key. Must also be defined as an `attribute` | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | (Optional) The number of read units for this table. If the billing\_mode is `PROVISIONED`, this field is `required`. | `number` | `null` | no |
<<<<<<< HEAD
| <a name="input_read_target_value"></a> [read\_target\_value](#input\_read\_target\_value) | The read target value for the scaling metric | `number` | `70` | no |
| <a name="input_replica"></a> [replica](#input\_replica) | (Optional) Configuration block(s) with [DynamoDB Global Tables V2 (version 2019.11.21)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.V2.html) replication configurations. | `map(string)` | `{}` | no |
| <a name="input_restore_date_time"></a> [restore\_date\_time](#input\_restore\_date\_time) | (Optional) The time of the point-in-time recovery point to restore. | `string` | `null` | no |
| <a name="input_restore_source_name"></a> [restore\_source\_name](#input\_restore\_source\_name) | (Optional) The name of the table to restore. Must match the name of an existing table. | `string` | `null` | no |
| <a name="input_restore_to_latest_time"></a> [restore\_to\_latest\_time](#input\_restore\_to\_latest\_time) | (Optional) If set, restores table to the most recent point-in-time recovery point. | `bool` | `false` | no |
| <a name="input_server_side_encryption"></a> [server\_side\_encryption](#input\_server\_side\_encryption) | (Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS owned Customer Master Key if this argument isn't specified. | `map(string)` | `{}` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | (Optional) Indicates whether Streams are to be enabled (true) or disabled (false). | `bool` | `false` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | (Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are `KEYS_ONLY`, `NEW_IMAGE`, `OLD_IMAGE`, `NEW_AND_OLD_IMAGES`. | `string` | `null` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | (Optional) The storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`. | `string` | `null` | no |
| <a name="input_table_item"></a> [table\_item](#input\_table\_item) | (Required) JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item. | `string` | `""` | no |
| <a name="input_table_item_hash_key"></a> [table\_item\_hash\_key](#input\_table\_item\_hash\_key) | (Required) Hash key to use for lookups and identification of the item | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to populate on the created table. If configured with a provider [default\_tags configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Specify timeouts for creating, updating and deleting tables | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | (Optional) Defines ttl, has two properties, and can only be specified once | `map(string)` | `{}` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | (Optional) The number of write units for this table. If the billing\_mode is `PROVISIONED`, this field is `required`. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The arn of the table |
| <a name="output_id"></a> [id](#output\_id) | The name of the table |
| <a name="output_stream_arn"></a> [stream\_arn](#output\_stream\_arn) | The ARN of the Table Stream. Only available when `stream_enabled = true` |
| <a name="output_stream_label"></a> [stream\_label](#output\_stream\_label) | A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when `stream_enabled = true` |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
