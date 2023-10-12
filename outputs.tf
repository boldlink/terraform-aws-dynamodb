output "arn" {
  value       = aws_dynamodb_table.main.arn
  description = "The arn of the table"
}

output "id" {
  value       = aws_dynamodb_table.main.id
  description = "The name of the table"
}

output "hash_key" {
  value       = aws_dynamodb_table.main.hash_key
  description = "The hash key of the table"
}

output "stream_arn" {
  value       = aws_dynamodb_table.main.stream_arn
  description = "The ARN of the Table Stream. Only available when `stream_enabled = true`"
}

output "stream_label" {
  value       = aws_dynamodb_table.main.stream_label
  description = "A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when `stream_enabled = true`"
}

output "tags_all" {
  value       = aws_dynamodb_table.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [default_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}
