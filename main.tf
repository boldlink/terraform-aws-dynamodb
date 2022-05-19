############################
### DynamoDB table
############################
resource "aws_dynamodb_table" "main" {
  name           = local.name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null

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
      write_capacity     = var.billing_mode == "PROVISIONED" ? lookup(global_secondary_index.value, "write_capacity", null) : null
      read_capacity      = var.billing_mode == "PROVISIONED" ? lookup(global_secondary_index.value, "read_capacity", null) : null
      hash_key           = global_secondary_index.value.hash_key
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
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

  server_side_encryption {
    enabled     = var.sse_enabled
    kms_key_arn = var.sse_enabled && var.sse_kms_key_arn == null && var.create_sse_kms_key == false ? local.default_ddb_kms_key : (var.sse_enabled && var.sse_kms_key_arn == null && var.create_sse_kms_key ? try(aws_kms_key.ddbsse[0].arn, null) : (var.sse_enabled && var.sse_kms_key_arn != null && var.create_sse_kms_key == false ? var.sse_kms_key_arn : null))
  }

  ## Interpretation of above:
  ## Use default kms key if; sse is enabled, sse-kms-key-arn not provided and key creation not specified, i.e condition is false
  ## Create key if; sse is enabled, sse-kms-key-arn not provided and key creation is specified, i.e condition is true
  ## Use provided key if; sse is enabled, sse-kms-key-arn value is provided and key creation is not specified, i.e condition is false
  ## Otherwise the value is `null`

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
      write_capacity,
    ]
  }
}

resource "aws_kms_key" "ddbsse" {
  count                   = var.create_sse_kms_key ? 1 : 0
  description             = "KMS Key for ${local.name} DynamoDB SSE"
  policy                  = data.aws_iam_policy_document.sse_kms_policy.json
  deletion_window_in_days = var.key_deletion_window
  enable_key_rotation     = var.enable_key_rotation
}

resource "aws_kms_alias" "ddbsse" {
  count         = var.create_sse_kms_key ? 1 : 0
  name          = "alias/dynamodb/${local.name}"
  target_key_id = aws_kms_key.ddbsse[0].key_id
}

######################################
### Table Auto scaling
######################################
resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count              = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0
  max_capacity       = var.dynamodb_table_max_read_capacity
  min_capacity       = var.dynamodb_table_min_read_capacity
  resource_id        = "table/${aws_dynamodb_table.main.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count              = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    scale_in_cooldown  = lookup(var.autoscaling_read, "scale_in_cooldown", var.autoscaling_defaults["scale_in_cooldown"])
    scale_out_cooldown = lookup(var.autoscaling_read, "scale_out_cooldown", var.autoscaling_defaults["scale_out_cooldown"])
    target_value       = lookup(var.autoscaling_read, "target_value", var.autoscaling_defaults["target_value"])
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0
  max_capacity       = var.dynamodb_table_max_write_capacity
  min_capacity       = var.dynamodb_table_min_write_capacity
  resource_id        = "table/${aws_dynamodb_table.main.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "table_write_policy" {
  count              = var.billing_mode == "PROVISIONED" && var.enable_autoscaling && length(var.autoscaling_write) > 0 ? 1 : 0
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = lookup(var.autoscaling_write, "scale_in_cooldown", var.autoscaling_defaults["scale_in_cooldown"])
    scale_out_cooldown = lookup(var.autoscaling_write, "scale_out_cooldown", var.autoscaling_defaults["scale_out_cooldown"])
    target_value       = lookup(var.autoscaling_write, "target_value", var.autoscaling_defaults["target_value"])
  }
}

######################################
### Index Auto scaling
######################################

resource "aws_appautoscaling_target" "index_read" {
  for_each           = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? var.autoscaling_indexes : {}
  max_capacity       = try(each.value.read_max_capacity, null)
  min_capacity       = try(each.value.read_min_capacity, null)
  resource_id        = "table/${aws_dynamodb_table.main.name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "index_read_policy" {
  for_each           = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? var.autoscaling_indexes : {}
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.index_read[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_read[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.index_read[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.index_read[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = merge(var.autoscaling_defaults, each.value)["scale_in_cooldown"]
    scale_out_cooldown = merge(var.autoscaling_defaults, each.value)["scale_out_cooldown"]
    target_value       = merge(var.autoscaling_defaults, each.value)["target_value"]
  }
}

resource "aws_appautoscaling_target" "index_write" {
  for_each           = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? var.autoscaling_indexes : {}
  max_capacity       = try(each.value.write_max_capacity, null)
  min_capacity       = try(each.value.write_min_capacity, null)
  resource_id        = "table/${aws_dynamodb_table.main.name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "index_write_policy" {
  for_each           = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? var.autoscaling_indexes : {}
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.index_write[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_write[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.index_write[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.index_write[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = merge(var.autoscaling_defaults, each.value)["scale_in_cooldown"]
    scale_out_cooldown = merge(var.autoscaling_defaults, each.value)["scale_out_cooldown"]
    target_value       = merge(var.autoscaling_defaults, each.value)["target_value"]
  }
}

############################
### DynamoDB Item
############################
resource "aws_dynamodb_table_item" "main" {
  count      = var.create_dynamodb_item ? 1 : 0
  table_name = aws_dynamodb_table.main.name
  hash_key   = var.table_item_hash_key == null ? aws_dynamodb_table.main.hash_key : var.table_item_hash_key
  range_key  = var.item_range_key
  item       = var.table_item
}
