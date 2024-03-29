variable "name" {
  type        = string
  description = "(Required) The name of the table, this needs to be unique within a region."
}

variable "billing_mode" {
  type        = string
  description = "(Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are `PROVISIONED` and `PAY_PER_REQUEST`. Defaults to `PROVISIONED`"
  default     = "PROVISIONED"
}

variable "enable_autoscaling" {
  type        = bool
  description = "Determines whether to enable autoscaling for the DynamoDB table."
  default     = false
}

variable "autoscaling_defaults" {
  description = "A map of default autoscaling settings."
  type        = map(string)
  default = {
    scale_in_cooldown  = 0
    scale_out_cooldown = 0
    target_value       = 50
  }
}

variable "autoscaling_read" {
  description = "A map of read autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling"
  type        = map(string)
  default     = {}
}

variable "autoscaling_write" {
  description = "A map of write autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling"
  type        = map(string)
  default     = {}
}

variable "autoscaling_indexes" {
  description = "A map of index autoscaling configurations. See example in examples/autoscaling"
  type        = map(map(string))
  default     = {}
}

variable "hash_key" {
  type        = string
  description = "(Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an `attribute`"
}

variable "create_sse_kms_key" {
  type        = bool
  description = "Specify whether you want to create the sse_kms_key using this module."
  default     = false
}

variable "additional_kms_permissions" {
  type        = any
  description = "Add additional policies for the DDB SSE Key created by this module"
  default     = []
}

variable "enable_key_rotation" {
  type        = bool
  description = "Specify whether to enable kms key rotation."
  default     = true
}

variable "key_deletion_window" {
  type        = number
  description = "The waiting period, specified in number of days. Must be between `7` and `30`inclusive."
  default     = 7
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  description = "Specify whether to enable point-in-time-recovery for the dynamodb table."
  default     = true
}

variable "sse_enabled" {
  type        = bool
  description = "Specify whether server-side encryption is enabled for the dynamodb table. If enabled is `false` then server-side encryption is set to AWS owned CMK (shown as `DEFAULT` in the AWS console). If enabled is `true` and no `kms_key_arn` is specified then server-side encryption is set to AWS managed CMK (shown as `KMS` in the AWS console)."
  default     = false
}

variable "sse_kms_key_arn" {
  type        = string
  description = "Provide the ARN for the KMS key to use for DDB server-side encryption."
  default     = null
}

variable "range_key" {
  type        = string
  description = "(Optional, Forces new resource) The attribute to use as the range (sort) key. Must also be defined as an `attribute`"
  default     = null
}

variable "write_capacity" {
  type        = number
  description = "(Optional) The number of write units for this table. If the billing_mode is `PROVISIONED`, this field is `required`."
  default     = null
}

variable "read_capacity" {
  type        = number
  description = "(Optional) The number of read units for this table. If the billing_mode is `PROVISIONED`, this field is `required`."
  default     = null
}

variable "attributes" {
  type        = list(map(string))
  description = "(Required) List of nested attribute definitions. Only required for hash_key and range_key attributes."
  default     = []
}

variable "ttl" {
  type        = map(string)
  description = "(Optional) Defines ttl, has two properties, and can only be specified once"
  default     = {}
}

variable "local_secondary_index" {
  type        = list(any)
  description = "(Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  default     = []
}

variable "deletion_protection_enabled" {
  type        = bool
  description = "Enables deletion protection for table. Defaults to `false`"
  default     = false
}

variable "global_secondary_index" {
  type        = list(any)
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values. These mapped values are: `hash_key`, `name`, `non_key_attributes`, `projection_type`, `range_key`, `read_capacity` and `write_capacity`. **Note**: For `PAY_PER_REQUEST (On-demand)` mode both `read_capacity` and `write_capacity` are `not applicable`."
}

variable "replica" {
  type        = map(string)
  description = "(Optional) Configuration block(s) with [DynamoDB Global Tables V2 (version 2019.11.21)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.V2.html) replication configurations."
  default     = {}
}

variable "restore_source_name" {
  type        = string
  description = "(Optional) The name of the table to restore. Must match the name of an existing table."
  default     = null
}

variable "restore_to_latest_time" {
  type        = bool
  description = "(Optional) If set, restores table to the most recent point-in-time recovery point."
  default     = false
}

variable "restore_date_time" {
  type        = string
  description = "(Optional) The time of the point-in-time recovery point to restore."
  default     = null
}

variable "stream_enabled" {
  type        = bool
  description = "(Optional) Indicates whether Streams are to be enabled (true) or disabled (false)."
  default     = false
}

variable "stream_view_type" {
  type        = string
  description = "(Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are `KEYS_ONLY`, `NEW_IMAGE`, `OLD_IMAGE`, `NEW_AND_OLD_IMAGES`."
  default     = null
}

variable "table_class" {
  type        = string
  description = "(Optional) The storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`."
  default     = "STANDARD"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A map of tags to populate on the created table. If configured with a provider [default_tags configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "timeouts" {
  type        = map(string)
  description = "Specify timeouts for creating, updating and deleting tables"
  default     = {}
}

############################
### DynamoDB Item
############################
###### Table items fix
variable "table_items" {
  type        = any
  description = "Block for adding table item(s)."
  default     = {}
}
