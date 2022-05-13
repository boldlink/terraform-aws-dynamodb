output "outputs" {
  value = [
    module.ppr_dynamodb_table,
  ]
  description = "Various output values for dynamodb table with pay-per-request billing mode"
}
