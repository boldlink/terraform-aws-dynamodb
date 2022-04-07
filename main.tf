############################
### DynamoDB table
############################
resource "aws_dynamodb_table" "main" {
  name           = var.name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  write_capacity = var.write_capacity
  read_capacity  = var.read_capacity
  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  dynamic "ttl" {
    for_each = length(keys(var.ttl)) == 0 ? [] : [var.ttl]
    content {
      enabled        = ttl.value.enabled
      attribute_name = ttl.value.attribute_name
    }
  }
  dynamic "local_secondary_index" {
    for_each = length(keys(var.local_secondary_index)) == 0 ? [] : [var.local_secondary_index]
    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
    }
  }
  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index
    content {
      name               = global_secondary_index.value.name
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      hash_key           = global_secondary_index.value.hash_key
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }
  dynamic "point_in_time_recovery" {
    for_each = length(keys(var.point_in_time_recovery)) == 0 ? [] : [var.point_in_time_recovery]
    content {
      enabled = point_in_time_recovery.value.enabled
    }
  }
  dynamic "replica" {
    for_each = length(keys(var.replica)) == 0 ? [] : [var.replica]
    content {
      region_name = replica.value.region_name
      kms_key_arn = lookup(replica.value, "kms_key_arn", null)
    }
  }
  restore_source_name    = var.restore_source_name
  restore_to_latest_time = var.restore_to_latest_time
  restore_date_time      = var.restore_date_time
  stream_enabled         = var.stream_enabled
  stream_view_type       = var.stream_view_type
  dynamic "server_side_encryption" {
    for_each = length(keys(var.server_side_encryption)) == 0 ? [] : [var.server_side_encryption]
    content {
      enabled     = server_side_encryption.value.enabled
      kms_key_arn = lookup(server_side_encryption.value, "kms_key_arn", "alias/aws/dynamodb")
    }
  }
  timeouts {
    create = lookup(var.timeouts, "create", "10m")
    update = lookup(var.timeouts, "update", "60m")
    delete = lookup(var.timeouts, "delete", "10m")
  }
  table_class = var.table_class
  tags        = var.tags

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }

}

############################
### DynamoDB Item
############################
resource "aws_dynamodb_table_item" "main" {
  count      = var.table_item != null ? 1 : 0
  table_name = aws_dynamodb_table.main.name
  hash_key   = var.table_item_hash_key == null ? aws_dynamodb_table.main.hash_key : var.table_item_hash_key
  range_key  = var.item_range_key
  item       = var.table_item
}
