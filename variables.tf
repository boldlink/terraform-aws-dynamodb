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
  description = "Determines whether to enable autoscaling for the DynamoDB table"
  default     = false
}

variable "dynamodb_table_max_read_capacity" {
  type        = number
  description = "The maximum number of read units for this table."
  default     = 100
}

variable "dynamodb_table_min_read_capacity" {
  type        = number
  description = "The minimum number of read units for this table."
  default     = 5
}

variable "dynamodb_table_max_write_capacity" {
  type        = number
  description = "The maximum number of write units for this table."
  default     = 100
}

variable "dynamodb_table_min_write_capacity" {
  type        = number
  description = "The minimum number of write units for this table."
  default     = 5
}

variable "autoscaling_defaults" {
  description = "A map of default autoscaling settings"
  type        = map(string)
  default = {
    scale_in_cooldown  = 0
    scale_out_cooldown = 0
    target_value       = 70
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
  type        = map(string)
  description = "(Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  default     = {}
}

variable "global_secondary_index" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values"
}

variable "point_in_time_recovery" {
  type        = map(string)
  description = "(Optional) Enable point-in-time recovery"
  default     = {}
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

variable "server_side_encryption" {
  type        = map(string)
  description = "(Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS owned Customer Master Key if this argument isn't specified."
  default     = {}
}

variable "table_class" {
  type        = string
  description = "(Optional) The storage class of the table. Valid values are `STANDARD` and `STANDARD_INFREQUENT_ACCESS`."
  default     = null
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
variable "table_item_hash_key" {
  type        = string
  description = "(Required) Hash key to use for lookups and identification of the item"
  default     = ""
}

variable "item_range_key" {
  type        = string
  description = "(Optional) Range key to use for lookups and identification of the item. Required if there is range key defined in the table."
  default     = null
}

variable "table_item" {
  type        = string
  description = "(Required) JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item."
  default     = ""
}

variable "create_dynamodb_item" {
  type        = bool
  description = "Specify whether to create dynamodb item"
  default     = false
}
