output "outputs" {
  value = [
    module.dynamodb_table,
  ]
  description = "Various output values for dynamodb table with provisioned billing mode"
}
